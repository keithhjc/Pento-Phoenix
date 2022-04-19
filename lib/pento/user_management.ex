defmodule Pento.UserManagement do
  import Ecto.Query, warn: false
  alias Pento.Repo

  alias Pento.User.Role

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end
end
