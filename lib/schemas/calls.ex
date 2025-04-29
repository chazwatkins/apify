defmodule Apify.Calls do
  @moduledoc """
  Provides struct and type for a Calls
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          errorMessage: String.t() | nil,
          finishedAt: String.t() | nil,
          responseBody: String.t() | nil,
          responseStatus: number | nil,
          startedAt: String.t() | nil
        }

  defstruct [:__info__, :errorMessage, :finishedAt, :responseBody, :responseStatus, :startedAt]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errorMessage: {:string, :generic},
      finishedAt: {:string, :generic},
      responseBody: {:string, :generic},
      responseStatus: :number,
      startedAt: {:string, :generic}
    ]
  end
end
