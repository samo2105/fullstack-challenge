defmodule PeekWeb.Schema.Schema do
  @moduledoc """
  GraphQL Schema for bookings and events.
  """
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  alias PeekWeb.Resolvers.EventResolver
  alias PeekWeb.Resolvers.BookingResolver

  #
  # Queries
  #
  query do
    @desc "Get a list of events and their bookings"
    field :events, list_of(:event) do
      resolve(&EventResolver.events/3)
    end
  end

  #
  # Mutations
  #
  mutation do
    field :create_booking, :booking do
      arg :event_id, non_null(:id)
      arg :first_name, non_null(:string)
      arg :last_name, non_null(:string)

      resolve(&BookingResolver.create_booking/3)
    end
  end

  #
  # Event Object
  #
  object :event do
    field :id, non_null(:id)
    field :start, non_null(:naive_datetime)
    field :duration, non_null(:integer)
    field :title, non_null(:string)
    field :bookings, list_of(:booking)
  end

  #
  # Booking Object
  #
  object :booking do
    field :id, non_null(:id)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :event_id, non_null(:id)
  end

end
