defmodule Apify.KeyValueStoreStats do
  @moduledoc """
  Provides struct and type for a KeyValueStoreStats
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          deleteCount: number,
          listCount: number,
          readCount: number,
          s3StorageBytes: number,
          writeCount: number
        }

  defstruct [:__info__, :deleteCount, :listCount, :readCount, :s3StorageBytes, :writeCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      deleteCount: :number,
      listCount: :number,
      readCount: :number,
      s3StorageBytes: :number,
      writeCount: :number
    ]
  end
end
