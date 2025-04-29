defmodule Apify.ExampleRunInput do
  @moduledoc """
  Provides struct and type for a ExampleRunInput
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, body: String.t(), contentType: String.t()}

  defstruct [:__info__, :body, :contentType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [body: {:string, :generic}, contentType: {:string, :generic}]
  end
end
