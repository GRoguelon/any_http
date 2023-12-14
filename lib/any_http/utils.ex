defmodule AnyHttp.Utils do
  @moduledoc """
  Provides some functions which can be used with `AnyHttp` library.
  """

  ## Public functions

  @doc """
  Converts a `NaiveDateTime` into a valid RFC1123 value (mostly used in HTTP headers).

  It accepts a second argument to define if the return value should be a `string` or a `charlist`.

  ## Examples

      iex> AnyHttp.Utils.to_rfc1123_date(~N[2023-12-07 18:06:28.313171])
      "Thu, 07 Dec 2023 18:06:28 GMT"

      iex> AnyHttp.Utils.to_rfc1123_date(~N[2023-12-07 18:06:28.313171], :binary)
      "Thu, 07 Dec 2023 18:06:28 GMT"

      iex> AnyHttp.Utils.to_rfc1123_date(~N[2023-12-07 18:06:28.313171], :charlist)
      ~c"Thu, 07 Dec 2023 18:06:28 GMT"
  """
  @spec to_rfc1123_date(NaiveDateTime.t(), :binary | :charlist) :: charlist()
  def to_rfc1123_date(naive_datetime, format \\ :binary)

  def to_rfc1123_date(%NaiveDateTime{} = naive_datetime, :binary) do
    naive_datetime |> to_rfc1123_date(:charlist) |> List.to_string()
  end

  def to_rfc1123_date(%NaiveDateTime{} = naive_datetime, :charlist) do
    naive_datetime
    |> NaiveDateTime.to_erl()
    |> :calendar.universal_time_to_local_time()
    |> :httpd_util.rfc1123_date()
  end

  @doc """
  Converts a RFC1123 value into a `NaiveDateTime`.

  ## Examples

      iex> AnyHttp.Utils.from_rfc1123_date!("Thu, 07 Dec 2023 18:06:28 GMT")
      ~N[2023-12-07 18:06:28]

      iex> AnyHttp.Utils.from_rfc1123_date!(~c"Thu, 07 Dec 2023 18:06:28 GMT")
      ~N[2023-12-07 18:06:28]

      iex> AnyHttp.Utils.from_rfc1123_date!(~c"Thu, 99 Dec 2023 18:06:28 GMT")
      ** (ArgumentError) cannot convert {{2023, 12, 99}, {18, 6, 28}} to naive datetime, reason: :invalid_date
  """
  @spec from_rfc1123_date!(binary() | charlist()) :: NaiveDateTime.t() | no_return()
  def from_rfc1123_date!(value) when is_binary(value) do
    value |> String.to_charlist() |> from_rfc1123_date!()
  end

  def from_rfc1123_date!(value) do
    case :httpd_util.convert_request_date(value) do
      {{_year, _month, _day}, {_hour, _minute, _second}} = erl_date ->
        NaiveDateTime.from_erl!(erl_date)

      :bad_date ->
        raise ArgumentError, "invalid value, expected valid RFC1123 date, got: `#{value}`"
    end
  end
end
