defmodule Metamorphic.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  import ZXCVBN

  import Metamorphic.Encrypted.Users.Utils

  alias Metamorphic.Encrypted

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, Encrypted.Binary
    field :email_hash, Encrypted.HMAC
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true
    field :name, Encrypted.Binary
    field :name_hash, Encrypted.HMAC
    field :username, Encrypted.Binary
    field :username_hash, Encrypted.HMAC
    field :is_admin?, :boolean, default: false
    field :is_suspended?, :boolean, default: false
    field :is_deleted?, :boolean, default: false
    field :is_onboarded?, :boolean, default: false
    field :is_forgot_pwd?, :boolean, default: false
    field :key_hash, Encrypted.Binary
    field :key, Encrypted.Binary
    field :key_pair, {:map, Encrypted.Binary}
    field :user_key, Encrypted.Binary, redact: true
    field :conn_key, Encrypted.Binary, redact: true
    field :visibility, Ecto.Enum, values: [:public, :private, :relation], default: :public
    field :confirmed_at, :naive_datetime

    timestamps()
  end

  @doc """
  A user changeset for registration.

  It is important to validate the length of both email and password.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.

    * `:validate_email` - Validates the uniqueness of the email, in case
      you don't want to validate the uniqueness of the email (like when
      using this changeset for validations on a LiveView form before
      submitting the form), this option can be set to `false`.
      Defaults to `true`.
  """
  def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_email(opts)
    |> validate_username(opts)
    |> validate_password(opts)
  end

  defp validate_email(changeset, opts) do
    if opts[:key] && !is_nil(get_field(changeset, :email)) do
      email = get_field(changeset, :email)

      changeset
      |> validate_required([:email])
      |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/,
        message: "must have the @ sign and no spaces"
      )
      |> validate_length(:email, max: 160)
      |> add_email_hash()
      |> maybe_validate_unique_email_hash(opts)
      |> encrypt_email_change(opts, email)
    else
      changeset
      |> validate_required([:email])
      |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/,
        message: "must have the @ sign and no spaces"
      )
      |> validate_length(:email, max: 160)
      |> add_email_hash()
      |> maybe_validate_unique_email_hash(opts)
    end
  end

  defp add_email_hash(changeset) do
    if Map.has_key?(changeset.changes, :email) do
      changeset
      |> put_change(:email_hash, String.downcase(get_field(changeset, :email)))
    else
      changeset
    end
  end

  defp maybe_validate_unique_email_hash(changeset, opts) do
    if Keyword.get(opts, :validate_email, true) do
      changeset
      |> unsafe_validate_unique(:email_hash, Metamorphic.Repo)
      |> unique_constraint(:email_hash)
    else
      changeset
    end
  end

  defp encrypt_email_change(changeset, opts, email) do
    changeset
    |> put_change(:email, encrypt_user_data(email, opts[:user], opts[:key]))
  end

  defp encrypt_username_change(changeset, opts, username) do
    changeset
    |> put_change(:username, encrypt_user_data(username, opts[:user], opts[:key]))
  end

  defp validate_username(changeset, opts) do
    if email = get_change(changeset, :email) do
      changeset
      |> put_change(:username, email)
      |> add_username_hash()
      |> maybe_validate_unique_username_hash(opts)
    else
      if opts[:key] && !is_nil(get_field(changeset, :username)) do
        username = get_change(changeset, :username)

        changeset
        |> validate_required([:username])
        |> validate_length(:username, min: 2, max: 160)
        |> add_username_hash()
        |> maybe_validate_unique_username_hash(opts)
        |> encrypt_username_change(opts, username)
      else
        changeset
        |> validate_required([:username])
        |> validate_length(:username, min: 2, max: 160)
        |> add_username_hash()
        |> maybe_validate_unique_username_hash(opts)
      end
    end
  end

  defp add_username_hash(changeset) do
    if Map.has_key?(changeset.changes, :username) do
      changeset
      |> put_change(:username_hash, String.downcase(get_field(changeset, :username)))
    else
      changeset
    end
  end

  defp maybe_validate_unique_username_hash(changeset, opts) do
    if Keyword.get(opts, :validate_username, true) do
      changeset
      |> unsafe_validate_unique(:username_hash, Metamorphic.Repo)
      |> unique_constraint(:username_hash)
    else
      changeset
    end
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 72)
    |> check_zxcvbn_strength()
    |> maybe_hash_password(opts)
  end

  defp validate_password_change(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 72)
    |> check_zxcvbn_strength()
    |> maybe_hash_password_change(opts)
  end

  defp check_zxcvbn_strength(changeset) do
    password = get_change(changeset, :password)

    if password != nil do
      password_strength =
        zxcvbn(password, [
          get_change(changeset, :name),
          get_change(changeset, :username),
          get_change(changeset, :email)
        ])

      offline_fast_hashing =
        Map.get(password_strength.crack_times_display, :offline_fast_hashing_1e10_per_second)

      offline_slow_hashing =
        Map.get(password_strength.crack_times_display, :offline_slow_hashing_1e4_per_second)

      cond do
        password_strength.score === 4 && offline_fast_hashing === "centuries" ->
          changeset

        password_strength.score <= 4 ->
          add_error(
            changeset,
            :password,
            "may be cracked in #{offline_fast_hashing} to #{offline_slow_hashing}"
          )
      end
    else
      changeset
    end
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      # Hashing could be done with `Ecto.Changeset.prepare_changes/2`, but that
      # would keep the database transaction open longer and hurt performance.
      |> put_change(:hashed_password, Argon2.hash_pwd_salt(password, salt_len: 128))
      |> put_key_hash_and_key_pair_and_maybe_encrypt_user_data()
      |> delete_change(:password)
    else
      changeset
    end
  end

  defp maybe_hash_password_change(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      # Hashing could be done with `Ecto.Changeset.prepare_changes/2`, but that
      # would keep the database transaction open longer and hurt performance.
      |> put_change(:hashed_password, Argon2.hash_pwd_salt(password, salt_len: 128))
      |> put_new_key_hash_and_key_pair(password, opts)
      |> delete_change(:password)
    else
      changeset
    end
  end

  defp put_new_key_hash_and_key_pair(changeset, password, opts) do
    cond do
      opts[:change_password] || opts[:reset_password] ->
        %{user_key: user_key, private_key: private_key} =
          decrypt_user_keys(opts[:user].user_key, opts[:user], opts[:key])

        # Can update this as the private_key is not needed
        # so we  also don't need to make changes to they key pair.
        # We only need to get the user_key and make a new key_hash
        # with the new password.
        #
        # We can drop the put_change -> key_pair work. :)

        %{key_hash: new_key_hash} = Encrypted.Utils.generate_key_hash(password, user_key)
        e_private_key = Encrypted.Utils.encrypt(%{key: user_key, payload: private_key})

        changeset
        |> put_change(:key_hash, new_key_hash)
        |> put_change(:key_pair, %{public: opts[:user].key_pair["public"], private: e_private_key})

      true ->
        changeset
    end
  end

  defp put_key_hash_and_key_pair_and_maybe_encrypt_user_data(
         %Ecto.Changeset{
           valid?: true,
           changes: %{
             email: email,
             password: password,
             username: username
           }
         } = changeset
       ) do
    user_key = Encrypted.Utils.generate_key()
    user_attributes_key = Encrypted.Utils.generate_key()

    %{key_hash: key_hash} = Encrypted.Utils.generate_key_hash(password, user_key)
    %{public: public_key, private: private_key} = Encrypted.Utils.generate_key_pairs()

    encrypted_email = Encrypted.Utils.encrypt(%{key: user_attributes_key, payload: email})
    encrypted_username = Encrypted.Utils.encrypt(%{key: user_attributes_key, payload: username})
    encrypted_private_key = Encrypted.Utils.encrypt(%{key: user_key, payload: private_key})

    encrypted_user_attributes_key =
      Encrypted.Utils.encrypt_message_for_user_with_pk(user_attributes_key, %{
        public: public_key
      })

    changeset
    |> put_change(:email, encrypted_email)
    |> put_change(:key_hash, key_hash)
    |> put_change(:key_pair, %{public: public_key, private: encrypted_private_key})
    |> put_change(:user_key, encrypted_user_attributes_key)
    |> put_change(:username, encrypted_username)
  end

  @doc """
  A user changeset for changing the email.

  It requires the email to change otherwise an error is added.

  Since this is not generating encryption keys from scratch,
  like new user registration does, but rather using the
  current_user's existing keys, we use `encrypt_user_data/3`
  to encrypt the email change.
  """
  def email_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email])
    |> validate_email(opts)
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A user changeset for changing the password.

  This is used from within a user's settings.
  It must recrypt all user data with the new
  password.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password_change(opts)
  end

  @doc """
  A user changeset for changing the username.

  It requires the username to change otherwise an error is added.

  Since this is not generating encryption keys from scratch,
  like new user registration does, but rather using the
  current_user's existing keys, we use `encrypt_user_data/3`
  to encrypt the username change.
  """
  def username_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:username])
    |> validate_username(opts)
    |> case do
      %{changes: %{username: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :username, "did not change")
    end
  end

  @doc """
  A user changeset for changing the visiblity.

  It requires the visiblity to change otherwise an error is added.
  """
  def visibility_changeset(user, attrs, _opts \\ []) do
    user
    |> cast(attrs, [:visibility])
    |> validate_required([:visibility])
    |> case do
      %{changes: %{visibility: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :visibility, "did not change")
    end
  end

  @doc """
  A user changeset for changing the `is_forgot_pwd?` boolean.
  """
  def forgot_password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:is_forgot_pwd?, :key])
    |> maybe_store_key(opts)
    |> maybe_delete_key(opts)
    |> case do
      %{changes: %{is_forgot_pwd?: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :is_forgot_pwd?, "did not change")
    end
  end

  # We store the session key in an
  # encrypted binary (Cloak) to enable
  # the ability to reset your password
  # if you forget it.
  defp maybe_store_key(changeset, opts) do
    if get_field(changeset, :is_forgot_pwd?) do
      changeset
      |> put_change(:key, opts[:key])
    else
      changeset
    end
  end

  # We delete the saved session key
  # if you disable the `is_forgot_pwd?`
  # setting to protect your account and
  # remove the ability to reset your password
  # if you forget it.
  defp maybe_delete_key(changeset, _opts) do
    if get_field(changeset, :is_forgot_pwd?) do
      changeset
    else
      # we update the key to `nil` if `is_forgot_pwd?` is false
      changeset
      |> put_change(:key, nil)
    end
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(user, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no user or the user doesn't have a password, we call
  `Argon2.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%Metamorphic.Accounts.User{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Argon2.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Argon2.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end

  @doc """
  Verifies and decrypts a user's secret key hash and stores in a
  `key` variable. This is used to encrypt/decrypt a
  user's data.

  If there is no user or the user doesn't have a password, we call
  `Argon2.no_user_verify/0` to avoid timing attacks.
  """
  def valid_key_hash?(
        %Metamorphic.Accounts.User{hashed_password: hashed_password, key_hash: key_hash},
        password
      )
      when is_binary(hashed_password) and is_binary(key_hash) and byte_size(password) > 0 and
             byte_size(key_hash) > 0 do
    case Argon2.verify_pass(password, hashed_password) do
      true ->
        Encrypted.Utils.decrypt_key_hash(password, key_hash)

      _ ->
        false
    end
  end

  def valid_key_hash?(_, _) do
    Argon2.no_user_verify()
    false
  end
end
