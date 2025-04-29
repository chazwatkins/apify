defmodule Apify.GetLimitsResponse do
  @moduledoc """
  Provides struct and type for a GetLimitsResponse
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, data: Apify.AccountLimits.t()}

  defstruct [:__info__, :data]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: {Apify.AccountLimits, :t}]
  end
end
