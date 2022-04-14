defmodule Pento.Promo.Recipient do
  defstruct [:firstname, :email, :contact]
  @types %{first_name: :string, email: :string, contact: :string}

  import Ecto.Changeset

  def changeset(%__MODULE__{} = user, attrs) do
    # IO.inspect("recipient attrs")
    # IO.inspect(Map.keys(@types))
    {user, @types}
    # Map.keys(@types) returns [:contact, :email, :first_name]
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:first_name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
