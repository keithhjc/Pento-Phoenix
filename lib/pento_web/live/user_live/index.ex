defmodule PentoWeb.UserLive.Index do
  use PentoWeb, :live_view

  import PentoWeb.Helpers.IconHelper

  alias Pento.Accounts
  alias Pento.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :users, list_users())}
  end

  defp list_users do
    Accounts.list_users()
  end
end
