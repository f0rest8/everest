defmodule MetamorphicWeb.UserSessionController do
  use MetamorphicWeb, :controller

  alias Metamorphic.Accounts
  alias Metamorphic.Extensions.{AvatarProcessor}
  alias MetamorphicWeb.UserAuth

  def create(conn, %{"_action" => "registered"} = params) do
    create(conn, params, "Account created successfully!")
  end

  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/users/settings")
    |> create(params, "Password updated successfully!")
  end

  def create(conn, params) do
    create(conn, params, "Welcome back!")
  end

  defp create(conn, %{"user" => user_params}, info) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      conn
      |> put_flash(:success, info)
      |> UserAuth.log_in_user(user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Invalid email or password")
      |> put_flash(:email, String.slice(email, 0, 160))
      |> redirect(to: ~p"/users/log_in")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:success, "Logged out successfully.")
    |> clear_user_ets_data()
    |> UserAuth.log_out_user()
  end

  defp clear_user_ets_data(conn) do
    if key = Map.get(conn.assigns.current_user.connection, :id) do
      AvatarProcessor.delete_ets_avatar(key)
      conn
    else
      conn
    end
  end
end
