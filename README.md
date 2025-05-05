# Apify

Elixir client library for the [Apify API](https://docs.apify.com/api/v2), generated from the OpenAPI specification using [oapi_generator](https://github.com/aj-foster/open-api-generator).

This client provides a complete set of operations for interacting with the Apify platform, including:

- Managing actors and actor runs
- Working with actor tasks
- Handling datasets
- Managing webhooks

⚠️ This library is a work in progress.  Feel free to try it out.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `apify` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:apify, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/apify>.

## Usage

### Actor Runs

```elixir
# Get a specific actor run
{:ok, run} = Apify.ActorRun.get_run("my-run-id")

# List actor runs
{:ok, runs} = Apify.ActorRun.list_runs("my-actor-id")

# Start a new actor run
{:ok, run} = Apify.ActorRun.run_actor("my-actor-id", %{
  "memory": 2048,
  "timeout": 60,
  "build": "latest"
})
```

### Datasets

```elixir
# Get a dataset
{:ok, dataset} = Apify.Dataset.get_dataset("my-dataset-id")

# List datasets
{:ok, datasets} = Apify.Dataset.list_datasets()

# Get dataset items
{:ok, items} = Apify.Dataset.get_items("my-dataset-id")
```

### Webhooks

```elixir
# Create a webhook
{:ok, webhook} = Apify.Webhook.create_webhook(%{
  "eventTypes": ["ACTOR.RUN.SUCCEEDED"],
  "condition": %{
    "actorId": "my-actor-id"
  },
  "requestUrl": "https://example.com/webhook"
})

# Verify a webhook request
conn =
  |> Plug.Conn.read_body()
  |> case do
    {:ok, body, conn} ->
      case Apify.verify_webhook(body, conn.req_headers, "my-webhook-secret") do
        :ok ->
          {:ok, payload} = Apify.parse_webhook(Jason.decode!(body))
          # Process the webhook payload
          send_resp(conn, 200, "OK")
        {:error, reason} ->
          send_resp(conn, 401, "Unauthorized")
      end
    _ ->
      send_resp(conn, 400, "Bad Request")
  end
```

### Custom Requests

For endpoints not yet covered by the client, you can use the raw request function:

```elixir
{:ok, response} = Apify.raw(:get, "/v2/actor-runs/my-run-id")
```

## Configuration

To use this client with your Apify account, you'll need to configure it with your API token. There are several ways to do this:

### Using config.exs

```elixir
# In your config/config.exs
config :apify, :api_token, "your-apify-api-token"
```

### Using environment variables

```elixir
# In your config/config.exs
config :apify, :api_token, System.get_env("APIFY_API_TOKEN")
```

Then set the environment variable:

```bash
export APIFY_API_TOKEN="your-apify-api-token"
```

### Passing the token directly

You can also pass the token directly when making API calls:

```elixir
client = Apify.client(api_token: "your-apify-api-token")
Apify.ActorRun.get_run("my-run-id", client: client)
```

## Testing

The client includes a testing module that makes it easy to mock API responses:

```elixir
defmodule MyTest do
  use ExUnit.Case
  use Apify.Testing

  test "gets a run" do
    mock_apify Apify.ActorRun.get_run("my-run-id"), {:ok, %Apify.ActorRun{id: "my-run-id"}}

    result = MyModule.function_that_uses_apify()

    assert_apify_called Apify.ActorRun.get_run("my-run-id")
  end
end
```

## API Version

This client was generated from the Apify OpenAPI specification for API v2.
