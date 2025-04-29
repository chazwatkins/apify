defmodule Apify.Items do
  @moduledoc """
  Provides struct and type for a Items
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, key: String.t(), size: number}

  defstruct [:__info__, :key, :size]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [key: {:string, :generic}, size: :number]
  end
end
