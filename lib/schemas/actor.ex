defmodule Apify.Actor do
  @moduledoc """
  Provides struct and type for a Actor
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          createdAt: String.t(),
          defaultRunOptions: Apify.DefaultRunOptions.t(),
          deploymentKey: String.t(),
          description: String.t() | nil,
          exampleRunInput: map | Apify.ExampleRunInput.t() | nil,
          id: String.t(),
          isDeprecated: boolean | nil,
          isPublic: boolean,
          modifiedAt: String.t(),
          name: String.t(),
          pricingInfos:
            [
              Apify.FlatPricePerMonthActorPricingInfo.t()
              | Apify.FreeActorPricingInfo.t()
              | Apify.PayPerEventActorPricingInfo.t()
              | Apify.PricePerDatasetItemActorPricingInfo.t()
            ]
            | nil,
          restartOnError: boolean | nil,
          stats: Apify.ActorStats.t(),
          taggedBuilds: map | Apify.TaggedBuilds.t() | nil,
          title: String.t() | nil,
          userId: String.t(),
          username: String.t(),
          versions: [Apify.Version.t()]
        }

  defstruct [
    :__info__,
    :createdAt,
    :defaultRunOptions,
    :deploymentKey,
    :description,
    :exampleRunInput,
    :id,
    :isDeprecated,
    :isPublic,
    :modifiedAt,
    :name,
    :pricingInfos,
    :restartOnError,
    :stats,
    :taggedBuilds,
    :title,
    :userId,
    :username,
    :versions
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      createdAt: {:string, :generic},
      defaultRunOptions: {Apify.DefaultRunOptions, :t},
      deploymentKey: {:string, :generic},
      description: {:string, :generic},
      exampleRunInput: {:union, [:map, {Apify.ExampleRunInput, :t}]},
      id: {:string, :generic},
      isDeprecated: :boolean,
      isPublic: :boolean,
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      pricingInfos: [
        union: [
          {Apify.FlatPricePerMonthActorPricingInfo, :t},
          {Apify.FreeActorPricingInfo, :t},
          {Apify.PayPerEventActorPricingInfo, :t},
          {Apify.PricePerDatasetItemActorPricingInfo, :t}
        ]
      ],
      restartOnError: :boolean,
      stats: {Apify.ActorStats, :t},
      taggedBuilds: {:union, [:map, {Apify.TaggedBuilds, :t}]},
      title: {:string, :generic},
      userId: {:string, :generic},
      username: {:string, :generic},
      versions: [{Apify.Version, :t}]
    ]
  end
end
