defmodule Apify.StoreListActor do
  @moduledoc """
  Provides struct and type for a StoreListActor
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          categories: [String.t()] | nil,
          currentPricingInfo: Apify.CurrentPricingInfo.t(),
          description: String.t(),
          id: String.t(),
          name: String.t(),
          notice: String.t() | nil,
          pictureUrl: String.t() | nil,
          stats: Apify.ActorStats.t(),
          title: String.t(),
          url: String.t() | nil,
          userFullName: String.t(),
          userPictureUrl: String.t() | nil,
          username: String.t()
        }

  defstruct [
    :__info__,
    :categories,
    :currentPricingInfo,
    :description,
    :id,
    :name,
    :notice,
    :pictureUrl,
    :stats,
    :title,
    :url,
    :userFullName,
    :userPictureUrl,
    :username
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      categories: [string: :generic],
      currentPricingInfo: {Apify.CurrentPricingInfo, :t},
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      notice: {:string, :generic},
      pictureUrl: {:string, :generic},
      stats: {Apify.ActorStats, :t},
      title: {:string, :generic},
      url: {:string, :generic},
      userFullName: {:string, :generic},
      userPictureUrl: {:string, :generic},
      username: {:string, :generic}
    ]
  end
end
