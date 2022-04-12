defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}
  import PentoWeb.Helpers.IconHelper

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       score: 0,
       message: "Make a guess:",
       current_time: time(),
       answer: :rand.uniform(10) |> to_string(),
       correct_answer: false
     )}
  end

  # Order matters. This should precede the wrong option
  def handle_event("guess", %{"number" => guess} = data, %{assigns: %{answer: guess}} = socket) do
    message = "Congratulations. Your guess #{guess} is correct. "
    score = socket.assigns.score + 1

    {
      :noreply,
      assign(
        socket,
        current_time: time(),
        message: message,
        score: score,
        correct_answer: true
      )
    }
  end

  # NOTE: Pattern matching condition
  def handle_event("guess", %{"number" => guess} = data, %{assigns: %{answer: answer}} = socket) do
    IO.inspect(data)
    IO.inspect(socket)
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {
      :noreply,
      assign(
        socket,
        current_time: time(),
        message: message,
        score: score
      )
    }
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  def render(assigns) do
    ~H"""
    <style>
      .pento-score {
        # color: red;
      }
      .guess-box {
        width: 140px;
        font-family: 'Roboto', sans-serif;
        font-size: 31px;
        color: #000;
        # border: 1px solid #7999F0;
        transition: all 0.3s ease 0s;
        background-color: #ccdbfd;
        padding: 15px;
        border-radius: 45px;
        box-shadow:  0px 8px 15px rgba(0, 0, 0, 0.1);
      }

      .guess-box:hover {
        background-color: #abc4ff;
        box-shadow: 0px 15px 20px rgba(133, 188, 243, 0.4);
        color: white;
        transform: translateY(-7px);
      }
    </style>
    <h1>Your score: <span class="pento-score"><%= @score %></span></h1>
    <h2>Answer: <%= @answer %></h2>
    <h2><%= @message %></h2>

    <!-- Render SVG -->
    <%= PentoWeb.Helpers.IconHelper.icon_tag(@socket, "active", class: "something") %>
    <%= icon_tag(@socket, "active", class: "something") %>
    <h2>It's <%= @current_time %></h2>
    <%= if @correct_answer do %>
      <%= live_patch "Restart", to: Routes.live_path(@socket, PentoWeb.WrongLive) %>
    <% else %>
    <h2>
    <div class = "guess-boxes">
    <%= for n <- 0..9 do %>
    <a class="guess-box" href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
    <% end %>
    </div>
    </h2>
    <% end %>
    """
  end
end
