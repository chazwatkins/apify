defmodule Apify.DatasetStats do
  @moduledoc """
  Provides struct and type for a DatasetStats
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          readCount: number,
          storageBytes: number,
          writeCount: number
        }

  defstruct [:__info__, :readCount, :storageBytes, :writeCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [readCount: :number, storageBytes: :number, writeCount: :number]
  end
end
