defmodule Apify do
  @moduledoc """
  Apify API client for Elixir

  This library provides a client for the Apify API. It handles authentication, request serialization,
  and response deserialization.

  ## Usage

  The client is used by the operation modules to make requests to the Apify API:

      # Using the default client
      Apify.ActorRuns.get_run("my-run-id")

      # Using a custom client
      client = Apify.client(api_token: "my-token")
      Apify.ActorRuns.get_run("my-run-id", client: client)

  ## Configuration

  The client can be configured with the following options:

  * `api_token` (string): API token to use for authentication. If not provided, the client will
    use the token configured in the application environment.

  * `server` (string): API server to use. Defaults to "https://api.apify.com".

  * `stack` (list): List of plugins to use for the request. Defaults to the stack configured in
    the application environment.

  * `wrap` (boolean): Whether to wrap the response in a tuple. Defaults to `true`.

  ## Examples

      # Using the default client
      Apify.ActorRuns.get_run("my-run-id")

      # Using a custom client
      client = Apify.client(api_token: "my-token")
      Apify.ActorRuns.get_run("my-run-id", client: client)

      # Using a custom server
      client = Apify.client(server: "https://custom-api.apify.com")
      Apify.ActorRuns.get_run("my-run-id", client: client)
  """

  @doc """
  Create a client for the Apify API

  ## Options

  * `api_token` (string): API token to use for authentication. If not provided, the client will
    use the token configured in the application environment.

  * `server` (string): API server to use. Defaults to "https://api.apify.com".

  * `stack` (list): List of plugins to use for the request. Defaults to the stack configured in
    the application environment.

  * `wrap` (boolean): Whether to wrap the response in a tuple. Defaults to `true`.

  ## Examples

      # Using the default client
      client = Apify.client()

      # Using a custom client
      client = Apify.client(api_token: "my-token")

      # Using a custom server
      client = Apify.client(server: "https://custom-api.apify.com")
  """
  @spec client(keyword) :: module
  def client(_opts \\ []) do
    # Return the client module
    Apify.Client
  end

  @doc """
  Make a raw request to the Apify API

  This function is useful for making requests to endpoints that are not yet supported by the client.

  ## Options

  * `client` (keyword): Client options to use for the request. See `client/1` for more information.

  ## Examples

      # Using the default client
      Apify.raw(:get, "/v2/actor-runs/my-run-id")

      # Using a custom client
      client = Apify.client(api_token: "my-token")
      Apify.raw(:get, "/v2/actor-runs/my-run-id", nil, client: client)
  """
  @spec raw(atom, String.t(), term, keyword) :: {:ok, term} | {:error, term}
  def raw(method, url, body \\ nil, opts \\ []) do
    client_module = opts[:client] || client()

    # Extract stack from options
    stack = opts[:stack]

    # Create client options without stack and client
    client_opts =
      opts
      |> Keyword.drop([:client])
      |> Keyword.put_new(:wrap, true)

    # Add stack to client options if present
    client_opts =
      if stack do
        Keyword.put(client_opts, :stack, stack)
      else
        client_opts
      end

    # Create query params without client, stack, and wrap
    query = Keyword.drop(opts, [:client, :stack, :wrap])

    client_module.request(%{
      args: [],
      call: {__MODULE__, :raw},
      url: url,
      body: body,
      method: method,
      query: query,
      request: [{"application/json", :map}],
      response: [{200, :map}, {404, :map}],
      opts: client_opts
    })
  end

  @doc """
  Verify a webhook request signature

  This function verifies that a webhook request was signed with the expected secret.
  It compares the signature in the request headers with a computed signature of the
  request body.

  ## Parameters

  * `body` - The raw request body as a binary
  * `headers` - A map or keyword list of request headers
  * `secret` - The webhook secret used to sign the request

  ## Examples

      iex> Apify.verify_webhook(conn.body_params, conn.req_headers, "webhook-secret")
      :ok

      iex> Apify.verify_webhook(conn.body_params, conn.req_headers, "wrong-secret")
      {:error, :invalid_signature}
  """
  @spec verify_webhook(binary, map | keyword, String.t()) ::
          :ok | {:error, :invalid_signature | :missing_signature}
  def verify_webhook(body, headers, secret) do
    Apify.WebhookVerifier.verify(body, headers, secret)
  end

  @doc """
  Parse a webhook payload

  This function parses a webhook payload into a structured format. It extracts the
  event type and data from the payload.

  ## Parameters

  * `body` - The request body as a map

  ## Examples

      iex> Apify.parse_webhook(%{"eventType" => "ACTOR.RUN.SUCCEEDED", "data" => %{"actorId" => "abc123"}})
      {:ok, %{event: "ACTOR.RUN.SUCCEEDED", data: %{"actorId" => "abc123"}}}
  """
  @spec parse_webhook(map) :: {:ok, map} | {:error, :invalid_payload}
  def parse_webhook(body) do
    Apify.WebhookVerifier.parse(body)
  end
end
