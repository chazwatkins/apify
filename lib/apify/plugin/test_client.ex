defmodule Apify.Plugin.TestClient do
  @moduledoc """
  Local client used for testing purposes

  For more information on the testing facilities available in this library, see `Apify.Testing`.
  """
  alias Apify.Error
  alias Apify.Operation
  alias Apify.Plugin.TypedDecoder
  alias Apify.Testing

  @doc """
  Perform a client operation using mocks, and record the call for later assertions
  """
  @spec request(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def request(operation, _opts) do
    # Record the call for later assertions
    {module, function, args} = Operation.get_caller(operation)
    Testing.Store.put_call({module, function, args})

    # Get the mock result
    case Testing.get_mock_result(operation) do
      {:ok, data} -> ok(operation, data)
      {:ok, data, opts} -> ok(operation, data, opts)
      {:error, data} -> error(operation, data)
      {:error, data, opts} -> error(operation, data, opts)
      nil -> default_response(operation)
    end
  end

  @spec ok(Operation.t(), any, keyword) :: {:ok, Operation.t()}
  defp ok(operation, data, opts \\ []) do
    code = Keyword.get(opts, :code, 200)
    {:ok, %Operation{operation | response_body: data, response_code: code}}
  end

  @spec error(Operation.t(), any, keyword) :: {:error, Error.t()}
  defp error(operation, data, opts \\ [])

  defp error(operation, :not_found, _opts) do
    error = %{
      "error" => %{
        "message" => "Not Found"
      }
    }

    TypedDecoder.normalize_errors(
      %Operation{operation | response_body: error, response_code: 404},
      []
    )
  end

  defp error(operation, :rate_limited, _opts) do
    error = %{
      "error" => %{
        "message" => "API rate limit exceeded"
      }
    }

    TypedDecoder.normalize_errors(
      %Operation{operation | response_body: error, response_code: 429},
      []
    )
  end

  defp error(operation, :unauthorized, _opts) do
    error = %{
      "error" => %{
        "message" => "Unauthorized"
      }
    }

    TypedDecoder.normalize_errors(
      %Operation{operation | response_body: error, response_code: 401},
      []
    )
  end

  defp error(_operation, _data, opts) do
    code = opts[:code] || 400
    message = "Error during test request"

    {:error, Error.new(code, message)}
  end

  defp default_response(operation) do
    # Default to a 200 OK response with an empty map
    url = operation.request_url

    if String.contains?(url, "/actor-runs/") and String.contains?(url, "test-run-id") do
      # For actor run requests, return a test run
      {:ok,
       %Operation{
         operation
         | response_body: %{"id" => "test-run-id"},
           response_code: 200,
           response_headers: []
       }}
    else
      # Default response
      {:ok, %Operation{operation | response_body: %{}, response_code: 200, response_headers: []}}
    end
  end
end
