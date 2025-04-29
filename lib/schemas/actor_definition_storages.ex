defmodule Apify.ActorDefinitionStorages do
  @moduledoc """
  Provides struct and type for a ActorDefinitionStorages
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, dataset: map | nil}

  defstruct [:__info__, :dataset]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [dataset: :map]
  end
end
