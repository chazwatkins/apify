defmodule Apify.ProcessedRequest do
  @moduledoc """
  Provides struct and type for a ProcessedRequest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          requestId: String.t(),
          uniqueKey: String.t(),
          wasAlreadyHandled: boolean,
          wasAlreadyPresent: boolean
        }

  defstruct [:__info__, :requestId, :uniqueKey, :wasAlreadyHandled, :wasAlreadyPresent]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      requestId: {:string, :generic},
      uniqueKey: {:string, :generic},
      wasAlreadyHandled: :boolean,
      wasAlreadyPresent: :boolean
    ]
  end
end
