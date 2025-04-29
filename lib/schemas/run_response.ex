defmodule Apify.RunResponse do
  @moduledoc """
  Provides struct and type for a RunResponse
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, data: map}

  defstruct [:__info__, :data]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: :map]
  end
end
