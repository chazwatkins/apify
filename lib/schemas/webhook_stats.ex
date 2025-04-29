defmodule Apify.WebhookStats do
  @moduledoc """
  Provides struct and type for a WebhookStats
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, totalDispatches: number | nil}

  defstruct [:__info__, :totalDispatches]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [totalDispatches: :number]
  end
end
