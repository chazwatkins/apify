defmodule Apify.TaggedBuilds do
  @moduledoc """
  Provides struct and type for a TaggedBuilds
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, latest: map | Apify.TaggedBuildsLatest.t() | nil}

  defstruct [:__info__, :latest]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [latest: {:union, [:map, {Apify.TaggedBuildsLatest, :t}]}]
  end
end
