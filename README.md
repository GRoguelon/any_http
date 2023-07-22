# Any HTTP

Elixir library which wraps the main HTTP libraries. It allows the final project to decide which
HTTP library they want to use and provide an unified interface.

[Documentation](https://hexdocs.pm/any_http)

## Installation

```elixir
def deps do
  [
    {:any_http, "~> 0.1"}
  ]
end
```

## Configuration

Declare your favorite HTTP library in the configuration

```elixir
config :any_http, client_adapter: AnyHttp.Adapters.Req
```

Ensure, you added the corresponding dependency for the adapter:

```elixir
def deps do
  [
    {:req, "~> 0.3"}
  ]
end
```

## Usage

Just call the `AnyHttp` module to interact with HTTP:

```elixir
AnyHttp.post("https://my_server/api", %{"content-type" => "application/json"}, %{hello: "world"}, receive_timeout: :timer.seconds(5))
```

The result will look like:

```elixir
{:ok, %AnyHttp.Response{status: 201, headers: [{"content-type", "application/json"}], body: %{"bye" => "world"}}}
```
