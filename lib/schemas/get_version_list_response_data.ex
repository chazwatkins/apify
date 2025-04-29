defmodule Apify.GetVersionListResponseData do
  @moduledoc """
  Provides struct and type for a GetVersionListResponseData
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, items: [Apify.Version.t()], total: number}

  defstruct [:__info__, :items, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [items: [{Apify.Version, :t}], total: :number]
  end
end
