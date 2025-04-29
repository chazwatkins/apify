defmodule Apify.Run do
  @moduledoc """
  Provides struct and type for a Run
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actId: String.t(),
          actorTaskId: String.t() | nil,
          buildId: String.t(),
          buildNumber: String.t(),
          chargedEventCounts: map | nil,
          containerUrl: String.t(),
          defaultDatasetId: String.t(),
          defaultKeyValueStoreId: String.t(),
          defaultRequestQueueId: String.t(),
          exitCode: number | nil,
          finishedAt: String.t(),
          gitBranchName: String.t() | nil,
          id: String.t(),
          isContainerServerReady: boolean | nil,
          isStatusMessageTerminal: boolean | nil,
          meta: Apify.RunMeta.t(),
          options: Apify.RunOptions.t(),
          pricingInfo:
            Apify.FlatPricePerMonthActorPricingInfo.t()
            | Apify.FreeActorPricingInfo.t()
            | Apify.PayPerEventActorPricingInfo.t()
            | Apify.PricePerDatasetItemActorPricingInfo.t()
            | nil,
          startedAt: String.t(),
          stats: Apify.RunStats.t(),
          status: String.t(),
          statusMessage: String.t() | nil,
          usage: map | nil,
          usageTotalUsd: number | nil,
          usageUsd: map | nil,
          userId: String.t()
        }

  defstruct [
    :__info__,
    :actId,
    :actorTaskId,
    :buildId,
    :buildNumber,
    :chargedEventCounts,
    :containerUrl,
    :defaultDatasetId,
    :defaultKeyValueStoreId,
    :defaultRequestQueueId,
    :exitCode,
    :finishedAt,
    :gitBranchName,
    :id,
    :isContainerServerReady,
    :isStatusMessageTerminal,
    :meta,
    :options,
    :pricingInfo,
    :startedAt,
    :stats,
    :status,
    :statusMessage,
    :usage,
    :usageTotalUsd,
    :usageUsd,
    :userId
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
      chargedEventCounts: :map,
      containerUrl: {:string, :generic},
      defaultDatasetId: {:string, :generic},
      defaultKeyValueStoreId: {:string, :generic},
      defaultRequestQueueId: {:string, :generic},
      exitCode: :number,
      finishedAt: {:string, :generic},
      gitBranchName: {:string, :generic},
      id: {:string, :generic},
      isContainerServerReady: :boolean,
      isStatusMessageTerminal: :boolean,
      meta: {Apify.RunMeta, :t},
      options: {Apify.RunOptions, :t},
      pricingInfo:
        {:union,
         [
           {Apify.FlatPricePerMonthActorPricingInfo, :t},
           {Apify.FreeActorPricingInfo, :t},
           {Apify.PayPerEventActorPricingInfo, :t},
           {Apify.PricePerDatasetItemActorPricingInfo, :t}
         ]},
      startedAt: {:string, :generic},
      stats: {Apify.RunStats, :t},
      status: {:string, :generic},
      statusMessage: {:string, :generic},
      usage: :map,
      usageTotalUsd: :number,
      usageUsd: :map,
      userId: {:string, :generic}
    ]
  end
end
