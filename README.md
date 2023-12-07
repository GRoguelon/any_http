# Any HTTP

Elixir library which wraps the main HTTP libraries. It allows the final project to decide which
HTTP library they want to use and provide an unified interface.

[Documentation](https://hexdocs.pm/any_http)

## Installation

```elixir
def deps do
  [
    {:any_http, "~> 0.3"}
  ]
end
```

## Configuration

### [Req](https://github.com/wojtekmach/req)

Declare your favorite HTTP library in the configuration

```elixir
config :any_http, client_adapter: AnyHttp.Adapters.Req
```

Ensure, you added the corresponding dependency for the adapter:

```elixir
def deps do
  [
    {:req, "~> 0.4"}
  ]
end
```

### [:httpc](https://www.erlang.org/doc/man/httpc.html)

Declare your favorite HTTP library in the configuration

```elixir
config :any_http, client_adapter: AnyHttp.Adapters.Httpc
```

## Usage

Just call the `AnyHttp` module to interact with HTTP:

```elixir
AnyHttp.post(
  # Provide the URL as a string or an URI
  "https://my_server/api",
  # Provide the HTTP headers as map or list of tuple, put nil if none
  %{"content-type" => "application/json"},
  # Provide the body, put nil if none
  Jason.encode!(%{hello: "world"}),
  # Provide the adapter options, can be ommited
  receive_timeout: :timer.seconds(5)
)
```

The result will look like:

```elixir
{:ok,
  %AnyHttp.Response{
    status: 201,
    headers: %{"content-type" => ["application/json"]},
    body: "{\"bye\":\"world\"}"
  }
}
```
