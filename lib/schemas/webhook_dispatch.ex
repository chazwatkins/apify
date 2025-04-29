defmodule Apify.WebhookDispatch do
  @moduledoc """
  Provides struct and type for a WebhookDispatch
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          calls: Apify.Calls.t() | nil,
          createdAt: String.t(),
          eventData: Apify.EventData.t(),
          eventType: String.t(),
          id: String.t(),
          status: String.t(),
          userId: String.t(),
          webhookId: String.t()
        }

  defstruct [
    :__info__,
    :calls,
    :createdAt,
    :eventData,
    :eventType,
    :id,
    :status,
    :userId,
    :webhookId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      calls: {Apify.Calls, :t},
      createdAt: {:string, :generic},
      eventData: {Apify.EventData, :t},
      eventType: {:string, :generic},
      id: {:string, :generic},
      status: {:string, :generic},
      userId: {:string, :generic},
      webhookId: {:string, :generic}
    ]
  end
end
