defmodule AnyHttp.Client do
  @moduledoc """
  Defines the behaviour for the HTTP adapters to implement.
  """

  ## Typespecs

  @typedoc "Represents an URL."
  @type url :: AnyHttp.Types.url()

  @typedoc "Represents the headers of a request."
  @type headers :: AnyHttp.Types.headers()

  @typedoc "Represents the body of a request."
  @type body :: AnyHttp.Types.body()

  @typedoc "Represents the response of a request."
  @type response :: AnyHttp.Types.response()

  @typedoc "Represents the options passed to the adapter."
  @type opts :: AnyHttp.Types.opts()

  @typedoc "Represents the result of a request. It can be either a success or an error."
  @type result :: AnyHttp.Types.result()

  ## Behaviour callbacks

  @doc """
  Makes a HEAD request to the given URL.
  """
  @callback head(url(), headers()) :: result()

  @doc """
  Makes a HEAD request to the given URL.

  Same as `head/2` but with options.
  """
  @callback head(url(), headers(), opts()) :: result()

  @doc """
  Makes a GET request to the given URL.
  """
  @callback get(url(), headers(), body()) :: result()

  @doc """
  Makes a GET request to the given URL.

  Same as `get/3` but with options.
  """
  @callback get(url(), headers(), body(), opts()) :: result()

  @doc """
  Makes a POST request to the given URL.
  """
  @callback post(url(), headers(), body()) :: result()

  @doc """
  Makes a POST request to the given URL.

  Same as `post/3` but with options.
  """
  @callback post(url(), headers(), body(), opts()) :: result()

  @doc """
  Makes a PUT request to the given URL.
  """
  @callback put(url(), headers(), body()) :: result()

  @doc """
  Makes a PUT request to the given URL.

  Same as `put/3` but with options.
  """
  @callback put(url(), headers(), body(), opts()) :: result()

  @doc """
  Makes a PATCH request to the given URL.
  """
  @callback patch(url(), headers(), body()) :: result()

  @doc """
  Makes a PATCH request to the given URL.

  Same as `patch/3` but with options.
  """
  @callback patch(url(), headers(), body(), opts()) :: result()

  @doc """
  Makes a DELETE request to the given URL.
  """
  @callback delete(url(), headers(), body()) :: result()

  @doc """
  Makes a DELETE request to the given URL.

  Same as `delete/3` but with options.
  """
  @callback delete(url(), headers(), body(), opts()) :: result()
end
