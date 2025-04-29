defmodule Apify.DefaultRunOptions do
  @moduledoc """
  Provides struct and type for a DefaultRunOptions
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          build: String.t(),
          memoryMbytes: number,
          timeoutSecs: number
        }

  defstruct [:__info__, :build, :memoryMbytes, :timeoutSecs]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [build: {:string, :generic}, memoryMbytes: :number, timeoutSecs: :number]
  end
end
