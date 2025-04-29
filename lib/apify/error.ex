defmodule Apify.Error do
  @moduledoc """
  Error struct for Apify API errors

  This struct is returned when an API request fails. It includes information about the error,
  such as the HTTP status code and the error message.
  """

  @type t :: %__MODULE__{
          code: integer,
          message: String.t(),
          reason: atom
        }

  defstruct [:code, :message, :reason]

  @doc """
  Create a new error struct

  ## Examples

      iex> Error.new(404, "Not Found")
      %Error{code: 404, message: "Not Found", reason: :not_found}

      iex> Error.new(500, "Internal Server Error")
      %Error{code: 500, message: "Internal Server Error", reason: :internal_server_error}

  """
  @spec new(integer, String.t()) :: t
  def new(code, message) do
    %__MODULE__{
      code: code,
      message: message,
      reason: reason_for_code(code)
    }
  end

  @doc """
  Get the reason atom for an HTTP status code

  ## Examples

      iex> Error.reason_for_code(404)
      :not_found

      iex> Error.reason_for_code(500)
      :internal_server_error

  """
  @spec reason_for_code(integer) :: atom
  def reason_for_code(code) do
    case code do
      400 -> :bad_request
      401 -> :unauthorized
      403 -> :forbidden
      404 -> :not_found
      409 -> :conflict
      422 -> :unprocessable_entity
      429 -> :too_many_requests
      500 -> :internal_server_error
      502 -> :bad_gateway
      503 -> :service_unavailable
      504 -> :gateway_timeout
      _ -> :unknown
    end
  end
end
