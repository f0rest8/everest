defmodule MetamorphicWeb.UserConnectionLive do
  use MetamorphicWeb, :live_view

  alias Metamorphic.Accounts

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Connections
      <:subtitle>This is your connections dashboard.</:subtitle>
      <:actions :if={!@current_user.confirmed_at}>
        <.button type="button" class="bg-brand-500" phx-click={JS.patch(~p"/users/confirm")}>
          Confirm my account
        </.button>
      </:actions>
    </.header>

    <.flash_group flash={@flash} />

    <div class="w-full sm:w-auto">
      <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4">
        <.link
          navigate={~p"/users/connections"}
          class="group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
        >
          <span class="absolute inset-0 rounded-2xl bg-zinc-50 transition group-hover:bg-zinc-100 sm:group-hover:scale-105">
          </span>
          <span class="relative flex items-center gap-4 sm:flex-col">
            <.icon name="hero-user-group" class="h-6 w-6" /> Connections
          </span>
        </.link>
        <.link
          navigate={~p"/posts/"}
          class="group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
        >
          <span class="absolute inset-0 rounded-2xl bg-zinc-50 transition group-hover:bg-zinc-100 sm:group-hover:scale-105">
          </span>
          <span class="relative flex items-center gap-4 sm:flex-col">
            <.icon name="hero-chat-bubble-oval-left" class="h-6 w-6" /> Timeline
          </span>
        </.link>
      </div>
    </div>

    <.modal :if={@live_action in [:new, :edit]} id="post-modal" show on_cancel={JS.patch(~p"/posts")}>
      <.live_component
        module={MetamorphicWeb.PostLive.FormComponent}
        id={@post.id || :new}
        title={@page_title}
        action={@live_action}
        post={@post}
        user={@current_user}
        key={@key}
        patch={~p"/posts"}
      />
    </.modal>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do

    end

    {:ok, assign(socket, :user_connections, Accounts.list_user_connections(socket.assigns.current_user))}
  end
end
