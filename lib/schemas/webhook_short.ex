defmodule Apify.WebhookShort do
  @moduledoc """
  Provides struct and type for a WebhookShort
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          condition: Apify.WebhookCondition.t(),
          createdAt: String.t(),
          doNotRetry: boolean,
          eventTypes: [String.t()],
          id: String.t(),
          ignoreSslErrors: boolean,
          isAdHoc: boolean | nil,
          lastDispatch: Apify.WebhookShortLastDispatch.t() | nil,
          modifiedAt: String.t(),
          requestUrl: String.t(),
          shouldInterpolateStrings: boolean | nil,
          stats: Apify.WebhookShortStats.t() | nil,
          userId: String.t()
        }

  defstruct [
    :__info__,
    :condition,
    :createdAt,
    :doNotRetry,
    :eventTypes,
    :id,
    :ignoreSslErrors,
    :isAdHoc,
    :lastDispatch,
    :modifiedAt,
    :requestUrl,
    :shouldInterpolateStrings,
    :stats,
    :userId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      condition: {Apify.WebhookCondition, :t},
      createdAt: {:string, :generic},
      doNotRetry: :boolean,
      eventTypes: [string: :generic],
      id: {:string, :generic},
      ignoreSslErrors: :boolean,
      isAdHoc: :boolean,
      lastDispatch: {Apify.WebhookShortLastDispatch, :t},
      modifiedAt: {:string, :generic},
      requestUrl: {:string, :generic},
      shouldInterpolateStrings: :boolean,
      stats: {Apify.WebhookShortStats, :t},
      userId: {:string, :generic}
    ]
  end
end
