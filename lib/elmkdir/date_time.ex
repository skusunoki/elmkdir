defmodule Elmkdir.DateTime do
  @spec now() :: DateTime.t() | {:error, String.t()}
  def now() do
    Calendar.put_time_zone_database(Tzdata.TimeZoneDatabase)

    case DateTime.now("Asia/Tokyo") do
      {:ok, date_time} -> date_time
      {:error, _} -> {:error, "Failed to put time zone database"}
    end
  end

  @doc """
  Convert a DateTime struct to a year string.

  ## Examples

      iex> Elmkdir.DateTime.to_year(~U[2024-04-06 09:21:05.732000Z])
      "2024"
  """
  def to_year(date_time) do
    date_time.year
    |> Integer.to_string()
    |> String.pad_leading(4, "0")
  end

  @doc """
  Convert a DateTime struct to a month string.

  ## Examples

      iex> Elmkdir.DateTime.to_month(~U[2024-04-06 09:21:05.732000Z])
      "04"
  """
  def to_month(date_time) do
    date_time.month
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  @doc """
  Convert a DateTime struct to a day string.

  ## Examples

      iex> Elmkdir.DateTime.to_day(~U[2024-04-06 09:21:05.732000Z])
      "06"
  """
  def to_day(date_time) do
    date_time.day
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  @doc """
  Convert a DateTime struct to a hour string.

  ## Examples

      iex> Elmkdir.DateTime.to_hour(~U[2024-04-06 09:21:05.732000Z])
      "09"
  """
  def to_hour(date_time) do
    date_time.hour
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  @doc """
  Convert a DateTime struct to a minute string.

  ## Examples

      iex> Elmkdir.DateTime.to_minute(~U[2024-04-06 09:21:05.732000Z])
      "21"
  """
  def to_minute(date_time) do
    date_time.minute
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  @doc """
  Convert a DateTime struct to a second string.

  ## Examples

      iex> Elmkdir.DateTime.to_second(~U[2024-04-06 09:21:05.732000Z])
      "05"
  """
  def to_second(date_time) do
    date_time.second
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  @doc """
  Convert a DateTime struct to a week string.
  """
  def to_week(date_time) do
    {date_time.year, date_time.month, date_time.day}
    |> :calendar.iso_week_number()
    |> elem(1)
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end
  @doc """
  Convert a DateTime struct to a period string.

  ## Examples

        iex> Elmkdir.DateTime.to_period(~U[2024-04-06 09:21:05.732000Z])
        "04"
  """
  def to_period(date_time) do
    period_calendar =
      [1,1,1,1,1,2,2,2,2,3,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,9,10,10,10,10,11,11,11,11,12,12,12,12,12,12 ]

    period_calendar
    |> Enum.at(to_week(date_time) |> String.to_integer() )
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  @doc """
  Convert a DateTime struct to a yyyymmdd string.

  ## Examples

      iex> Elmkdir.DateTime.to_yyyymmddhhMMss(~U[2024-04-06 09:21:05.732000Z])
      "20240406092105"
  """
  def to_yyyymmddhhMMss(date_time) do
    to_year(date_time) <>
      to_month(date_time) <>
      to_day(date_time) <>
      to_hour(date_time) <>
      to_minute(date_time) <>
      to_second(date_time)
  end
end
