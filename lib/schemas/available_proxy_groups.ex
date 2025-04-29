defmodule Apify.AvailableProxyGroups do
  @moduledoc """
  Provides struct and type for a AvailableProxyGroups
  """
  use Apify.Encoder

  @type t :: %__MODULE__{ANOTHERGROUP: number, SOMEGROUP: number, __info__: map}

  defstruct [:ANOTHERGROUP, :SOMEGROUP, :__info__]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ANOTHERGROUP: :number, SOMEGROUP: :number]
  end
end
