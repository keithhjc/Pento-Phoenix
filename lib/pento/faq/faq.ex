defmodule Pento.FAQ.Faq do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :answer, :string
    field :question, :string
    field :votes, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer, :votes])
    |> validate_required([:question])
  end

  def upvote_changeset(faq, attrs) do
    faq
    |> cast(attrs, [:votes])
    |> validate_required([:votes])
  end

  def answer_changeset(faq, attrs) do
    faq
    |> cast(attrs, [:answer])
    |> validate_required(:answer)
    |> validate_length(:answer, min: 5)
  end
end
