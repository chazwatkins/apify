defmodule Apify.PutRecordRequest do
  @moduledoc """
  Provides struct and type for a PutRecordRequest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, foo: String.t() | nil}

  defstruct [:__info__, :foo]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [foo: {:string, :generic}]
  end
end
