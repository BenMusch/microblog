defmodule MicroblogWeb.UpdatesChannel do
  use MicroblogWeb, :channel

  def join("updates:all", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("all", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
