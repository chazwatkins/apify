defmodule Apify.Plugin.ReqClient do
  @moduledoc """
  Plugin for making HTTP requests using Req

  This plugin is used in the default stack to make HTTP requests to the Apify API.
  """

  alias Apify.Error
  alias Apify.Operation

  @doc """
  Make an HTTP request using Req

  This function is used in the default stack to make HTTP requests to the Apify API.
  """
  @spec request(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def request(operation, _opts) do
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

        {:ok,
         %Operation{
           operation
           | response_body: body,
             response_code: status,
             response_headers: response_headers
         }}

      {:error, error} ->
        {:error, Error.new(0, "HTTP request failed: #{inspect(error)}")}
    end
  end
end
