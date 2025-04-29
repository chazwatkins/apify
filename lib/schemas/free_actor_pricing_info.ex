defmodule Apify.FreeActorPricingInfo do
  @moduledoc """
  Provides struct and type for a FreeActorPricingInfo
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          apifyMarginPercentage: number | nil,
          createdAt: DateTime.t() | nil,
          notifiedAboutChangeAt: DateTime.t() | nil,
          notifiedAboutFutureChangeAt: DateTime.t() | nil,
          pricingModel: String.t() | nil,
          reasonForChange: String.t() | nil,
          startedAt: DateTime.t() | nil
        }

  defstruct [
    :__info__,
    :apifyMarginPercentage,
    :createdAt,
    :notifiedAboutChangeAt,
    :notifiedAboutFutureChangeAt,
    :pricingModel,
    :reasonForChange,
    :startedAt
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      apifyMarginPercentage: :number,
      createdAt: {:string, :date_time},
      notifiedAboutChangeAt: {:string, :date_time},
      notifiedAboutFutureChangeAt: {:string, :date_time},
      pricingModel: {:const, "FREE"},
      reasonForChange: {:string, :generic},
      startedAt: {:string, :date_time}
    ]
  end
end
