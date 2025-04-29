defmodule Apify.Build do
  @moduledoc """
  Provides struct and type for a Build
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actId: String.t(),
          actorDefinition: Apify.ActorDefinition.t() | nil,
          buildNumber: String.t(),
          finishedAt: String.t() | nil,
          id: String.t(),
          inputSchema: String.t() | nil,
          meta: Apify.BuildsMeta.t(),
          options: map | nil,
          readme: String.t() | nil,
          startedAt: String.t(),
          stats: map | nil,
          status: String.t(),
          usage: map | nil,
          usageTotalUsd: number | nil,
          usageUsd: map | nil,
          userId: String.t()
        }

  defstruct [
    :__info__,
    :actId,
    :actorDefinition,
    :buildNumber,
    :finishedAt,
    :id,
    :inputSchema,
    :meta,
    :options,
    :readme,
    :startedAt,
    :stats,
    :status,
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
      actorDefinition: {:union, [{Apify.ActorDefinition, :t}, :null]},
      buildNumber: {:string, :generic},
      finishedAt: {:string, :generic},
      id: {:string, :generic},
      inputSchema: {:string, :generic},
      meta: {Apify.BuildsMeta, :t},
      options: :map,
      readme: {:string, :generic},
      startedAt: {:string, :generic},
      stats: :map,
      status: {:string, :generic},
      usage: :map,
      usageTotalUsd: :number,
      usageUsd: :map,
      userId: {:string, :generic}
    ]
  end
end
