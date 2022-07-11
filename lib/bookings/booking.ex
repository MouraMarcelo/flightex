defmodule Flightex.Bookings.Booking do
  @keys [:id, :complete_date, :local_origin, :local_destination, :user_id]
  @enforce_keys @keys

  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_id) do
    booking = %__MODULE__{
      id: UUID.uuid4(),
      complete_date: complete_date,
      local_origin: local_origin,
      local_destination: local_destination,
      user_id: user_id
    }

    {:ok, booking}
  end

  # def build(_local_origin, _local_destination, _complete_date, _user_id) do
  #   {:error, "Invalid parameters"}
  # end
end
