defmodule Pento.SurveyTest do
  use Pento.DataCase

  alias Pento.Survey

  describe "demographics" do
    alias Pento.Survey.Demographic

    import Pento.SurveyFixtures

    @invalid_attrs %{gender: nil, year_of_birth: nil}

    test "list_demographics/0 returns all demographics" do
      demographic = demographic_fixture()
      assert Survey.list_demographics() == [demographic]
    end

    test "get_demographic!/1 returns the demographic with given id" do
      demographic = demographic_fixture()
      assert Survey.get_demographic!(demographic.id) == demographic
    end

    test "create_demographic/1 with valid data creates a demographic" do
      valid_attrs = %{gender: "some gender", year_of_birth: 42}

      assert {:ok, %Demographic{} = demographic} = Survey.create_demographic(valid_attrs)
      assert demographic.gender == "some gender"
      assert demographic.year_of_birth == 42
    end

    test "create_demographic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Survey.create_demographic(@invalid_attrs)
    end

    test "update_demographic/2 with valid data updates the demographic" do
      demographic = demographic_fixture()
      update_attrs = %{gender: "some updated gender", year_of_birth: 43}

      assert {:ok, %Demographic{} = demographic} =
               Survey.update_demographic(demographic, update_attrs)

      assert demographic.gender == "some updated gender"
      assert demographic.year_of_birth == 43
    end

    test "update_demographic/2 with invalid data returns error changeset" do
      demographic = demographic_fixture()
      assert {:error, %Ecto.Changeset{}} = Survey.update_demographic(demographic, @invalid_attrs)
      assert demographic == Survey.get_demographic!(demographic.id)
    end

    test "delete_demographic/1 deletes the demographic" do
      demographic = demographic_fixture()
      assert {:ok, %Demographic{}} = Survey.delete_demographic(demographic)
      assert_raise Ecto.NoResultsError, fn -> Survey.get_demographic!(demographic.id) end
    end

    test "change_demographic/1 returns a demographic changeset" do
      demographic = demographic_fixture()
      assert %Ecto.Changeset{} = Survey.change_demographic(demographic)
    end
  end

  describe "ratings" do
    alias Pento.Survey.Rating

    import Pento.SurveyFixtures

    @invalid_attrs %{stars: nil}

    test "list_ratings/0 returns all ratings" do
      ratings = ratings_fixture()
      assert Survey.list_ratings() == [ratings]
    end

    test "get_ratings!/1 returns the ratings with given id" do
      ratings = ratings_fixture()
      assert Survey.get_ratings!(ratings.id) == ratings
    end

    test "create_ratings/1 with valid data creates a ratings" do
      valid_attrs = %{stars: 42}

      assert {:ok, %Rating{} = ratings} = Survey.create_ratings(valid_attrs)
      assert ratings.stars == 42
    end

    test "create_ratings/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Survey.create_ratings(@invalid_attrs)
    end

    test "update_ratings/2 with valid data updates the ratings" do
      ratings = ratings_fixture()
      update_attrs = %{stars: 43}

      assert {:ok, %Rating{} = ratings} = Survey.update_ratings(ratings, update_attrs)
      assert ratings.stars == 43
    end

    test "update_ratings/2 with invalid data returns error changeset" do
      ratings = ratings_fixture()
      assert {:error, %Ecto.Changeset{}} = Survey.update_ratings(ratings, @invalid_attrs)
      assert ratings == Survey.get_ratings!(ratings.id)
    end

    test "delete_ratings/1 deletes the ratings" do
      ratings = ratings_fixture()
      assert {:ok, %Rating{}} = Survey.delete_ratings(ratings)
      assert_raise Ecto.NoResultsError, fn -> Survey.get_ratings!(ratings.id) end
    end

    test "change_ratings/1 returns a ratings changeset" do
      ratings = ratings_fixture()
      assert %Ecto.Changeset{} = Survey.change_ratings(ratings)
    end
  end
end
