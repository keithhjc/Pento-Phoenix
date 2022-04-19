defmodule Pento.User.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
