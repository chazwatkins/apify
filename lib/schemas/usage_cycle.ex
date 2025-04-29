defmodule Apify.UsageCycle do
  @moduledoc """
  Provides struct and type for a UsageCycle
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, endAt: String.t(), startAt: String.t()}

  defstruct [:__info__, :endAt, :startAt]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [endAt: {:string, :generic}, startAt: {:string, :generic}]
  end
end
