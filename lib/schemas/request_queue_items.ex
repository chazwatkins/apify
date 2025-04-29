defmodule Apify.RequestQueueItems do
  @moduledoc """
  Provides struct and type for a RequestQueueItems
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          errorMessages: [String.t()] | nil,
          handledAt: String.t() | nil,
          headers: map | nil,
          id: String.t(),
          loadedUrl: String.t() | nil,
          method: String.t(),
          noRetry: boolean | nil,
          payload: map | nil,
          retryCount: number,
          uniqueKey: String.t(),
          url: String.t(),
          userData: map | nil
        }

  defstruct [
    :__info__,
    :errorMessages,
    :handledAt,
    :headers,
    :id,
    :loadedUrl,
    :method,
    :noRetry,
    :payload,
    :retryCount,
    :uniqueKey,
    :url,
    :userData
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errorMessages: [string: :generic],
      handledAt: {:string, :generic},
      headers: :map,
      id: {:string, :generic},
      loadedUrl: {:string, :generic},
      method: {:string, :generic},
      noRetry: :boolean,
      payload: :map,
      retryCount: :number,
      uniqueKey: {:string, :generic},
      url: {:string, :generic},
      userData: :map
    ]
  end
end
