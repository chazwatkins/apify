defmodule Apify.GetListOfActorsResponse do
  @moduledoc """
  Provides struct and type for a GetListOfActorsResponse
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, data: Apify.GetListOfActorsResponseData.t()}

  defstruct [:__info__, :data]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: {Apify.GetListOfActorsResponseData, :t}]
  end
end
