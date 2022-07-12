defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate_report(from_date, to_date) do
    booking_list =
      build_booking_list()
      |> Enum.filter(&is_between(&1, from_date, to_date))

    File.write("filtered_report.csv", booking_list)

    {:ok, "Report generated successfully"}
  end

  def generate(filename \\ "report.csv") do
    booking_list = build_booking_list()

    File.write(filename, booking_list)
  end

  defp build_booking_list() do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(&booking_string(&1))
  end

  defp booking_string(%Booking{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    date_formatted = NaiveDateTime.to_string(complete_date)
    "#{user_id},#{local_origin},#{local_destination},#{date_formatted}\n"
  end

  defp is_between(item, from_date, to_date) do
    date =
      item
      |> String.split(",")
      |> List.last()
      |> String.replace("\n", "")
      |> NaiveDateTime.from_iso8601!()

    date >= from_date and date <= to_date
  end
end
