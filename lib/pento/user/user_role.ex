defmodule Pento.User.UserRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_roles" do
    field :role_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(user_role, attrs) do
    user_role
    |> cast(attrs, [:user_id, :role_id])
    |> validate_required([:user_id, :role_id])
  end
end
