defmodule Apify.Plugin.JasonSerializer do
  @moduledoc """
  Plugin for serializing and deserializing JSON using Jason

  This plugin is used in the default stack to serialize request bodies to JSON and deserialize
  response bodies from JSON.
  """

  alias Apify.Error
  alias Apify.Operation

  @doc """
  Encode the request body as JSON

  This function is used in the default stack to serialize request bodies to JSON.
  """
  @spec encode_body(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def encode_body(%Operation{request_body: nil} = operation, _opts), do: {:ok, operation}

  def encode_body(%Operation{request_body: body} = operation, _opts) do
    case Jason.encode(body) do
      {:ok, encoded} ->
        {:ok, %Operation{operation | request_body: encoded}}

      {:error, %Jason.EncodeError{} = error} ->
        {:error, Error.new(400, "Invalid request body: #{Exception.message(error)}")}
    end
  end

  @doc """
  Decode the response body from JSON

  This function is used in the default stack to deserialize response bodies from JSON.
  """
  @spec decode_body(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def decode_body(%Operation{response_body: nil} = operation, _opts), do: {:ok, operation}

  def decode_body(%Operation{response_body: body} = operation, _opts) when is_binary(body) do
    case Jason.decode(body) do
      {:ok, decoded} ->
        {:ok, %Operation{operation | response_body: decoded}}

      {:error, %Jason.DecodeError{} = error} ->
        {:error, Error.new(500, "Invalid response body: #{Exception.message(error)}")}
    end
  end

  def decode_body(operation, _opts), do: {:ok, operation}
end
