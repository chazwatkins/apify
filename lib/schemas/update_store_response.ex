defmodule Apify.UpdateStoreResponse do
  @moduledoc """
  Provides struct and type for a UpdateStoreResponse
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, data: Apify.KeyValueStore.t()}

  defstruct [:__info__, :data]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: {Apify.KeyValueStore, :t}]
  end
end
