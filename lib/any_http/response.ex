defmodule AnyHttp.Response do
  @moduledoc """
  Defines a generic struct to encapsulate a HTTP response.
  """

  @enforce_keys [:status]
  defstruct [:status, headers: %{}, body: nil]

  ## Typespecs

  @type status :: 100..599

  @type headers :: %{binary() => [binary()]}

  @type body :: term()

  @type t :: %__MODULE__{status: status(), headers: headers(), body: body()}
end
