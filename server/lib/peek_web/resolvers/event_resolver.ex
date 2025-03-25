defmodule PeekWeb.Resolvers.EventResolver do
  alias Peek.Events.Event
  alias Peek.Repo

  def events(_, _, _) do
    events = Repo.all(Event)
              |> Repo.preload(:bookings)

    {:ok, events}
  end
end
