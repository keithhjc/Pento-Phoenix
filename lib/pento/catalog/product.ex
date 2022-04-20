defmodule Pento.Catalog.Product do
  use Ecto.Schema
  alias Pento.Survey.Rating
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string

    has_many :rating, Rating

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)

    # |> validate_number(:unit_price, less_than: product.unit_price)
  end

  def unit_price_changeset(product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_number(:unit_price, less_than: product.unit_price)
  end
end
