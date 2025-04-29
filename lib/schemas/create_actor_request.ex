defmodule Apify.CreateActorRequest do
  @moduledoc """
  Provides struct and type for a CreateActorRequest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          categories: [String.t()] | nil,
          defaultRunOptions: map | Apify.DefaultRunOptions.t() | nil,
          description: String.t() | nil,
          isPublic: boolean | nil,
          name: String.t() | nil,
          pricingInfos:
            [
              Apify.FlatPricePerMonthActorPricingInfo.t()
              | Apify.FreeActorPricingInfo.t()
              | Apify.PayPerEventActorPricingInfo.t()
              | Apify.PricePerDatasetItemActorPricingInfo.t()
            ]
            | nil,
          restartOnError: boolean | nil,
          seoDescription: String.t() | nil,
          seoTitle: String.t() | nil,
          title: String.t() | nil,
          versions: [Apify.Version.t()] | nil
        }

  defstruct [
    :__info__,
    :categories,
    :defaultRunOptions,
    :description,
    :isPublic,
    :name,
    :pricingInfos,
    :restartOnError,
    :seoDescription,
    :seoTitle,
    :title,
    :versions
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      categories: [string: :generic],
      defaultRunOptions: {:union, [:map, {Apify.DefaultRunOptions, :t}]},
      description: {:string, :generic},
      isPublic: :boolean,
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
      seoDescription: {:string, :generic},
      seoTitle: {:string, :generic},
      title: {:string, :generic},
      versions: [{Apify.Version, :t}]
    ]
  end
end
