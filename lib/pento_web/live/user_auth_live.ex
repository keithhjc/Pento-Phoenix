defmodule PentoWeb.UserAuthLive do
  import Phoenix.LiveView
  alias Pento.Accounts

  def on_mount(_, params, %{"user_token" => user_token}, socket) do
    # This information can be retrieved from plug.conn
    # user = Accounts.get_user_by_session_token(user_token)
    # socket =
    #   socket
    #   |> assign(:current_user, user)

    # IO.puts("Assign User with socket.private")
    # IO.inspect(socket.private)
    # DOC: assign_new: checks whether the key exist before making assign
    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token(user_token)
      end)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/login")}
    end
  end
end
