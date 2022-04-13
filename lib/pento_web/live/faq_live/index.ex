defmodule PentoWeb.FaqLive.Index do
  use PentoWeb, :live_view

  alias Pento.FAQ
  alias Pento.FAQ.Faq

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :faqs, list_faqs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :like, %{"id" => id}) do
    IO.inspect("liked")
    socket
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Faq")
    |> assign(:faq, FAQ.get_faq!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Faq")
    |> assign(:faq, %Faq{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Faqs")
    |> assign(:faq, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    faq = FAQ.get_faq!(id)
    {:ok, _} = FAQ.delete_faq(faq)

    {:noreply, assign(socket, :faqs, list_faqs())}
  end

  def handle_event("like", %{"id" => id}, socket) do
    faq = FAQ.get_faq!(id)
    {:ok, _} = FAQ.upvote_faq(faq)
    {:noreply, assign(socket, :faqs, list_faqs())}
  end

  defp list_faqs do
    FAQ.list_faqs()
  end
end
