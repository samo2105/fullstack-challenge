defmodule PeekWeb.Resolvers.BookingResolver do
  alias Peek.Bookings.Booking
  alias Peek.Repo

  def create_booking(_, %{event_id: event_id, first_name: first_name, last_name: last_name}, _) do
    booking_params = %{
      event_id: event_id,
      first_name: first_name,
      last_name: last_name,
    }

    changeset = Booking.changeset(%Booking{}, booking_params)

    case Repo.insert(changeset) do
      {:ok, booking} ->
        {:ok, booking}
      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
