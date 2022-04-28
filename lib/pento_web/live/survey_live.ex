defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view
  alias Pento.Survey
  alias __MODULE__.Component
  alias PentoWeb.DemographicLive

  def mount(_params, _session, socket) do
    # IO.inspect(socket)
    {:ok, socket
      |> assign_demographic
    }
  end

  defp assign_demographic(
    %{assigns: %{current_user: current_user}} = socket) do
    assign(socket,
    :demographic,
    Survey.get_demographic_by_user(current_user))
  end

end
