# Any HTTP

Elixir library which wraps the main HTTP libraries. It allows the final project to decide which
HTTP library they want to use and provide an unified interface.

[Documentation](https://hexdocs.pm/any_http)

## Installation

```elixir
def deps do
  [
    {:any_http, "~> 0.4"}
  ]
end
```

## Configuration

### [:httpc](https://www.erlang.org/doc/man/httpc.html)

`:httpc` is already part of your application because it's part of Erlang.

Change your configuration to declare Req as your adapter:
```elixir
config :any_http, client_adapter: AnyHttp.Adapters.Httpc

# You can provide default options to the adapter.
config :any_http, httpc_default_opts: []
```

### [Req](https://hexdocs.pm/req)

Add Req to your `mix.exs` file:
```elixir
def deps do
  [
    {:req, "~> 0.4"}
  ]
end
```

Change your configuration to declare Req as your adapter:
```elixir
config :any_http, client_adapter: AnyHttp.Adapters.Req

# You can provide default options to the adapter.
config :any_http, req_default_opts: []
```

### [:hackney](https://hexdocs.pm/hackney/)

Add Req to your `mix.exs` file:
```elixir
def deps do
  [
    {:hackney, "~> 1.20"}
  ]
end
```

Change your configuration to declare Req as your adapter:
```elixir
config :any_http, client_adapter: AnyHttp.Adapters.Hackney

# You can provide default options to the adapter.
config :any_http, hackney_default_opts: []
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
  ~s<{"hello": "world"}>,
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
