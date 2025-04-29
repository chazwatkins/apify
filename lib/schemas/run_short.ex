defmodule Apify.RunShort do
  @moduledoc """
  Provides struct and type for a RunShort
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actId: String.t(),
          actorTaskId: String.t() | nil,
          buildId: String.t(),
          buildNumber: String.t(),
          defaultDatasetId: String.t(),
          defaultKeyValueStoreId: String.t(),
          defaultRequestQueueId: String.t(),
          finishedAt: String.t(),
          id: String.t(),
          meta: Apify.RunShortMeta.t(),
          startedAt: String.t(),
          status: String.t(),
          usageTotalUsd: number
        }

  defstruct [
    :__info__,
    :actId,
    :actorTaskId,
    :buildId,
    :buildNumber,
    :defaultDatasetId,
    :defaultKeyValueStoreId,
    :defaultRequestQueueId,
    :finishedAt,
    :id,
    :meta,
    :startedAt,
    :status,
    :usageTotalUsd
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actId: {:string, :generic},
      actorTaskId: {:string, :generic},
      buildId: {:string, :generic},
      buildNumber: {:string, :generic},
      defaultDatasetId: {:string, :generic},
      defaultKeyValueStoreId: {:string, :generic},
      defaultRequestQueueId: {:string, :generic},
      finishedAt: {:string, :generic},
      id: {:string, :generic},
      meta: {Apify.RunShortMeta, :t},
      startedAt: {:string, :generic},
      status: {:string, :generic},
      usageTotalUsd: :number
    ]
  end
end
