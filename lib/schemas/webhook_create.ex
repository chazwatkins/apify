defmodule Apify.WebhookCreate do
  @moduledoc """
  Provides struct and type for a WebhookCreate
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          condition: Apify.WebhookCondition.t(),
          description: String.t() | nil,
          doNotRetry: boolean | nil,
          eventTypes: [String.t()],
          headersTemplate: String.t() | nil,
          idempotencyKey: String.t() | nil,
          ignoreSslErrors: boolean | nil,
          isAdHoc: boolean | nil,
          payloadTemplate: String.t() | nil,
          requestUrl: String.t(),
          shouldInterpolateStrings: boolean | nil
        }

  defstruct [
    :__info__,
    :condition,
    :description,
    :doNotRetry,
    :eventTypes,
    :headersTemplate,
    :idempotencyKey,
    :ignoreSslErrors,
    :isAdHoc,
    :payloadTemplate,
    :requestUrl,
    :shouldInterpolateStrings
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      condition: {Apify.WebhookCondition, :t},
      description: {:string, :generic},
      doNotRetry: :boolean,
      eventTypes: [string: :generic],
      headersTemplate: {:string, :generic},
      idempotencyKey: {:string, :generic},
      ignoreSslErrors: :boolean,
      isAdHoc: :boolean,
      payloadTemplate: {:string, :generic},
      requestUrl: {:string, :generic},
      shouldInterpolateStrings: :boolean
    ]
  end
end
