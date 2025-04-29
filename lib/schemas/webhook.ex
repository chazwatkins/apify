defmodule Apify.Webhook do
  @moduledoc """
  Provides struct and type for a Webhook
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          condition: Apify.WebhookCondition.t(),
          createdAt: String.t(),
          description: String.t() | nil,
          doNotRetry: boolean | nil,
          eventTypes: [String.t()],
          headersTemplate: String.t() | nil,
          id: String.t(),
          ignoreSslErrors: boolean,
          isAdHoc: boolean | nil,
          lastDispatch: Apify.WebhookLastDispatch.t() | nil,
          modifiedAt: String.t(),
          payloadTemplate: String.t() | nil,
          requestUrl: String.t(),
          shouldInterpolateStrings: boolean | nil,
          stats: Apify.WebhookStats.t() | nil,
          userId: String.t()
        }

  defstruct [
    :__info__,
    :condition,
    :createdAt,
    :description,
    :doNotRetry,
    :eventTypes,
    :headersTemplate,
    :id,
    :ignoreSslErrors,
    :isAdHoc,
    :lastDispatch,
    :modifiedAt,
    :payloadTemplate,
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
      description: {:string, :generic},
      doNotRetry: :boolean,
      eventTypes: [string: :generic],
      headersTemplate: {:string, :generic},
      id: {:string, :generic},
      ignoreSslErrors: :boolean,
      isAdHoc: :boolean,
      lastDispatch: {Apify.WebhookLastDispatch, :t},
      modifiedAt: {:string, :generic},
      payloadTemplate: {:string, :generic},
      requestUrl: {:string, :generic},
      shouldInterpolateStrings: :boolean,
      stats: {Apify.WebhookStats, :t},
      userId: {:string, :generic}
    ]
  end
end
