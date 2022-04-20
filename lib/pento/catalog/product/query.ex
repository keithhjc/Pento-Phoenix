defmodule Pento.Catalog.Product.Query do
  import Ecto.Query
  alias Pento.Catalog.Product
  alias Pento.Survey.Rating

  def base do
    Product
  end

  def with_user_ratings(user) do
    base()
    |> preload_user_ratings(user)
  end

  def preload_user_ratings(query, user) do
    # Loads all rating for the specified user
    ratings_query = Rating.Query.preload_user(user)

    query
    |> preload(rating: ^ratings_query)
  end
end
