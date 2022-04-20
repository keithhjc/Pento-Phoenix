defmodule Pento.SurveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Survey` context.
  """

  @doc """
  Generate a demographic.
  """
  def demographic_fixture(attrs \\ %{}) do
    {:ok, demographic} =
      attrs
      |> Enum.into(%{
        gender: "some gender",
        year_of_birth: 42
      })
      |> Pento.Survey.create_demographic()

    demographic
  end

  @doc """
  Generate a ratings.
  """
  def ratings_fixture(attrs \\ %{}) do
    {:ok, ratings} =
      attrs
      |> Enum.into(%{
        stars: 42
      })
      |> Pento.Survey.create_ratings()

    ratings
  end
end
