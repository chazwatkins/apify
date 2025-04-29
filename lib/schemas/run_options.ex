defmodule Apify.RunOptions do
  @moduledoc """
  Provides struct and type for a RunOptions
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          build: String.t(),
          diskMbytes: number,
          memoryMbytes: number,
          timeoutSecs: number
        }

  defstruct [:__info__, :build, :diskMbytes, :memoryMbytes, :timeoutSecs]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [build: {:string, :generic}, diskMbytes: :number, memoryMbytes: :number, timeoutSecs: :number]
  end
end
