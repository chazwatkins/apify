defmodule Apify.WebhookUpdate do
  @moduledoc """
  Provides struct and type for a WebhookUpdate
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          condition: Apify.WebhookUpdateCondition.t() | nil,
          description: String.t() | nil,
          doNotRetry: boolean | nil,
          eventTypes: [String.t()] | nil,
          headersTemplate: String.t() | nil,
          ignoreSslErrors: boolean | nil,
          isAdHoc: boolean | nil,
          payloadTemplate: String.t() | nil,
          requestUrl: String.t() | nil,
          shouldInterpolateStrings: boolean | nil
        }

  defstruct [
    :__info__,
    :condition,
    :description,
    :doNotRetry,
    :eventTypes,
    :headersTemplate,
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
      condition: {Apify.WebhookUpdateCondition, :t},
      description: {:string, :generic},
      doNotRetry: :boolean,
      eventTypes: [string: :generic],
      headersTemplate: {:string, :generic},
      ignoreSslErrors: :boolean,
      isAdHoc: :boolean,
      payloadTemplate: {:string, :generic},
      requestUrl: {:string, :generic},
      shouldInterpolateStrings: :boolean
    ]
  end
end
