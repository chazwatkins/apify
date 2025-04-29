defmodule Apify.Client do
  @moduledoc """
  Client for the Apify API

  This module provides a client for the Apify API. It handles authentication, request serialization,
  and response deserialization.

  ## Usage

  The client is used by the operation modules to make requests to the Apify API. You can also
  use it directly to make custom requests:

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
  alias Apify.Error
  alias Apify.Config
  alias Apify.Operation

  @doc """
  Make a request to the Apify API

  This function is called by the operation modules to make requests to the Apify API.
  It handles authentication, request serialization, and response deserialization.
  """
  @spec request(map) :: {:ok, term} | {:error, term} | Operation.t()
  def request(%{opts: opts} = info) do
    %Operation{
      request_method: method,
      request_server: server,
      request_url: url
    } = operation = Operation.new(info)

    metadata = %{
      client: __MODULE__,
      info: info,
      request_method: method,
      request_server: server,
      request_url: url
    }

    :telemetry.span([:apify, :request], metadata, fn ->
      result = make_request(operation)

      if Config.wrap(opts) do
        wrap_result(result, metadata)
      else
        {result, Map.put(metadata, :response_code, 0)}
      end
    end)
  end

  @doc """
  Make an HTTP request using Req

  This function makes an HTTP request using the Req library.
  """
  @spec make_request(Operation.t()) :: Operation.t() | Error.t()
  def make_request(%Operation{} = operation) do
    %Operation{
      request_body: body,
      request_headers: headers,
      request_method: method,
      request_params: params,
      request_server: server,
      request_url: url
    } = operation

    full_url = server <> url

    req_options = [
      method: method,
      url: full_url,
      headers: headers
    ]

    req_options =
      if params && Enum.any?(params) do
        Keyword.put(req_options, :params, params)
      else
        req_options
      end

    req_options =
      if body do
        Keyword.put(req_options, :body, body)
      else
        req_options
      end

    case Req.request(req_options) do
      {:ok, %{status: status, body: body, headers: headers}} ->
        response_headers = Enum.map(headers, fn {k, v} -> {to_string(k), to_string(v)} end)

        %Operation{
          operation
          | response_body: body,
            response_code: status,
            response_headers: response_headers
        }

      {:error, error} ->
        Error.new(0, "HTTP request failed: #{inspect(error)}")
    end
  end

  @spec wrap_result(Operation.t() | Error.t(), map) ::
          {:ok, map} | {{:ok, term}, map} | {{:error, term}, map}
  defp wrap_result(%Operation{response_body: nil, response_code: code}, metadata)
       when code < 300 do
    {:ok, Map.put(metadata, :response_code, code)}
  end

  defp wrap_result(%Operation{response_body: response, response_code: code}, metadata)
       when code < 300 do
    {{:ok, response}, Map.put(metadata, :response_code, code)}
  end

  defp wrap_result(%Operation{response_body: response, response_code: code}, metadata) do
    {{:error, response}, Map.put(metadata, :response_code, code)}
  end

  defp wrap_result(%Error{code: code, reason: reason} = error, metadata) do
    {{:error, error}, Map.merge(metadata, %{response_code: code, error: reason})}
  end
end
