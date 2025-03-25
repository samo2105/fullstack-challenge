defmodule PeekWeb.BookingsTest do
  use PeekWeb.ConnCase, async: true

  alias Peek.Events

  def create_booking_mutation(event_id) do
    """
      mutation{
        createBooking(eventId: #{event_id}, lastName: "cea", firstName: "sam"){
          eventId
          lastName
          firstName
        }
      }
    """
  end

  setup do
    event =
      Events.create_event(%{title: "wine factory", duration: 30, start: ~N[2021-01-01 20:00:00]})

    {:ok, event: event}
  end

  test "creates a booking", context do
    %{conn: conn, event: event} = context
    conn = post(conn, "/api", query: create_booking_mutation(event.id))

    assert json_response(conn, 200) == %{
             "data" => %{
               "createBooking" => %{
                 "firstName" => "sam",
                 "lastName" => "cea",
                 "eventId" => "#{event.id}"
               }
             }
           }
  end

  test "doesn't creates a booking when the field are invalid", context do
    %{conn: conn} = context
    conn = post(conn, "/api", query: create_booking_mutation("bad_id"))

    assert json_response(conn, 200) == %{
             "errors" => [
               %{
                 "locations" => [
                   %{
                     "column" => 19,
                     "line" => 2
                   }
                 ],
                 "message" => "Argument \"eventId\" has invalid value bad_id."
               }
             ]
           }
  end
end
