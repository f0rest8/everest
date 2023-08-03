defmodule MetamorphicWeb.PostLive.Components do
  @moduledoc """
  Components for posts.
  """
  use Phoenix.Component
  use MetamorphicWeb, :verified_routes

  alias Phoenix.LiveView.JS
  import MetamorphicWeb.CoreComponents, only: [icon: 1]
  import MetamorphicWeb.Gettext
  import MetamorphicWeb.Helpers

  attr :id, :string, required: true
  attr :stream, :list, required: true
  attr :card_click, :any, default: nil, doc: "the function for handling phx-click on each card"
  attr :page, :integer, required: true
  attr :end_of_timeline?, :boolean, required: true
  attr :current_user, :string, required: true
  attr :key, :string, required: true

  slot :action, doc: "the slot for showing user actions in the last table column"

  def cards(assigns) do
    ~H"""
    <span
      :if={@page > 1}
      class="text-3xl fixed bottom-2 right-2 bg-zinc-900 text-white rounded-lg p-3 text-center min-w-[65px] z-50 opacity-80"
    >
      <span class="text-sm">pg</span>
      <%= @page %>
    </span>
    <ul
      id={@id}
      phx-update="stream"
      phx-viewport-top={@page > 1 && "prev-page"}
      phx-viewport-bottom={!@end_of_timeline? && "next-page"}
      phx-page-loading
      class={[
        if(@end_of_timeline?, do: "pb-10", else: "pb-[calc(200vh)]"),
        if(@page == 1, do: "pt-10", else: "pt-[calc(200vh)]") &&
          "divide-y divide-brand-100"
      ]}
    >
      <li
        :for={{id, item} <- @stream}
        id={id}
        phx-click={@card_click.(item)}
        class={[
          "group flex gap-x-4 py-5 px-2",
          @card_click &&
            "transition hover:cursor-pointer hover:bg-brand-50 sm:hover:rounded-2xl sm:hover:scale-105"
        ]}
      >
        <.post
          :if={%Metamorphic.Timeline.Post{} = item}
          post={item}
          current_user={@current_user}
          key={@key}
        />
      </li>
    </ul>
    <div :if={@end_of_timeline?} class="mt-5 text-[50px] text-center">
      🎉 You made it to the beginning of time 🎉
    </div>
    """
  end

  attr :current_user, :string, required: true
  attr :key, :string, required: true
  attr :post, Metamorphic.Timeline.Post, required: true

  def post(assigns) do
    ~H"""
    <div class="sr-only">
      <.link navigate={~p"/posts/#{@post}"}>Show</.link>
    </div>
    <img
      class="h-12 w-12 flex-none rounded-full text-center"
      src={~p"/images/logo.svg"}
      alt="Metamorphic egg logo"
    />
    <div class="flex-auto">
      <div class="flex items-baseline justify-between gap-x-4">
        <p class="text-sm font-semibold leading-6 text-gray-900">
          <%= decr_post(@post.username, @current_user, get_post_key(@post), @key, @post) %>
        </p>
        <p class="flex-none text-xs text-gray-600">
          <time datetime={@post.inserted_at}><%= time_ago(@post.inserted_at) %></time>
        </p>
      </div>
      <p class="mt-1 line-clamp-2 text-sm leading-6 text-gray-600">
        <%= decr_post(@post.body, @current_user, get_post_key(@post), @key, @post) %>
      </p>
      <!-- favorite -->
      <div class="inline-flex space-x-2 align-middle">
        <div
          :if={@current_user && can_fav?(@current_user, @post)}
          class="inline-flex align-middle"
          phx-click="fav"
          phx-value-id={@post.id}
        >
          <.icon name="hero-star" class="h-4 w-4 hover:text-brand-600" />
          <span class="ml-1 text-xs"><%= @post.favs_count %></span>
        </div>

        <div
          :if={@current_user && !can_fav?(@current_user, @post)}
          class="inline-flex align-middle"
          phx-click="unfav"
          phx-value-id={@post.id}
        >
          <.icon name="hero-star-solid" class="h-4 w-4 text-brand-600" />
          <span class="ml-1 text-xs"><%= @post.favs_count %></span>
        </div>

        <div :if={!@current_user && @post.favs_count > 0} class="inline-flex align-middle">
          <.icon name="hero-star-solid" class="h-4 w-4 text-brand-600" />
          <span class="ml-1 text-xs"><%= @post.favs_count %></span>
        </div>
        <!-- repost -->
        <div
          :if={@current_user && can_repost?(@current_user, @post)}
          class="inline-flex align-middle"
          phx-click="repost"
          phx-value-id={@post.id}
          phx-value-body={decr_public_post(@post.body, get_post_key(@post))}
          phx-value-username={decr(@current_user.username, @current_user, @key)}
        >
          <.icon name="hero-arrow-path-rounded-square" class="h-4 w-4 hover:text-brand-600" />
          <span class="ml-1 text-xs"><%= @post.reposts_count %></span>
        </div>

        <div
          :if={@current_user && (@post.reposts_count > 0 && !can_repost?(@current_user, @post))}
          class="inline-flex align-middle"
        >
          <.icon name="hero-arrow-path-rounded-square" class="h-4 w-4" />
          <span class="ml-1 text-xs"><%= @post.reposts_count %></span>
        </div>

        <div :if={!@current_user && @post.reposts_count > 0} class="inline-flex align-middle">
          <.icon name="hero-arrow-path-rounded-square" class="h-4 w-4" />
          <span class="ml-1 text-xs"><%= @post.reposts_count %></span>
        </div>
      </div>
      <!-- actions -->
      <div class="inline-flex space-x-2 ml-1 text-xs align-middle">
        <span :if={@current_user && @post.user_id == @current_user.id}>
          <div class="sr-only">
            <.link navigate={~p"/posts/#{@post}"}>Show</.link>
          </div>
          <.link patch={~p"/posts/#{@post}/edit"} class="hover:text-brand-600">Edit</.link>
        </span>
        <.link
          :if={@current_user && @post.user_id == @current_user.id}
          phx-click={JS.push("delete", value: %{id: @post.id})}
          data-confirm="Are you sure?"
          class="hover:text-brand-600"
        >
          Delete
        </.link>
      </div>
    </div>
    """
  end
end