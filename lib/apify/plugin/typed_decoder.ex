defmodule Apify.Plugin.TypedDecoder do
  @moduledoc """
  Plugin for decoding response bodies into typed structs

  This plugin is used in the default stack to decode response bodies into typed structs based on
  the response type information in the operation.
  """

  alias Apify.Error
  alias Apify.Operation

  @doc """
  Decode the response body into a typed struct

  This function is used in the default stack to decode response bodies into typed structs based on
  the response type information in the operation.
  """
  @spec decode_response(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def decode_response(%Operation{response_body: nil} = operation, _opts), do: {:ok, operation}

  def decode_response(
        %Operation{response_body: body, response_code: code, response_types: types} = operation,
        _opts
      ) do
    case Enum.find(types, fn {status, _type} -> status == code end) do
      {_status, type} ->
        decoded = decode_value(body, type)
        {:ok, %Operation{operation | response_body: decoded}}

      nil ->
        {:ok, operation}
    end
  end

  @doc """
  Normalize error responses

  This function is used in the default stack to normalize error responses into `Apify.Error` structs.
  """
  @spec normalize_errors(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def normalize_errors(%Operation{response_code: code} = operation, _opts) when code < 400 do
    {:ok, operation}
  end

  def normalize_errors(%Operation{response_body: body, response_code: code}, _opts) do
    error =
      cond do
        is_map(body) && Map.has_key?(body, "error") ->
          Error.new(code, body["error"]["message"] || "Unknown error")

        is_map(body) && Map.has_key?(body, "message") ->
          Error.new(code, body["message"])

        true ->
          Error.new(code, "Request failed with status code #{code}")
      end

    {:error, error}
  end

  # Private helpers

  defp decode_value(value, {module, type}) when is_atom(module) and is_atom(type) do
    if function_exported?(module, :__fields__, 1) do
      fields = apply(module, :__fields__, [type])
      struct = struct(module)

      Enum.reduce(fields, struct, fn {field, field_type}, acc ->
        if Map.has_key?(value, to_string(field)) do
          field_value = decode_value(value[to_string(field)], field_type)
          Map.put(acc, field, field_value)
        else
          acc
        end
      end)
    else
      value
    end
  end

  defp decode_value(value, {:array, type}) when is_list(value) do
    Enum.map(value, &decode_value(&1, type))
  end

  defp decode_value(value, {:nullable, _type}) when is_nil(value), do: nil

  defp decode_value(value, {:nullable, type}), do: decode_value(value, type)

  defp decode_value(value, {:union, types}) do
    Enum.find_value(types, value, fn type ->
      try do
        decode_value(value, type)
      rescue
        _ -> nil
      end
    end)
  end

  defp decode_value(value, _type), do: value
end
