defmodule Apify.GetVersionResponse do
  @moduledoc """
  Provides struct and type for a GetVersionResponse
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, data: Apify.Version.t()}

  defstruct [:__info__, :data]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: {Apify.Version, :t}]
  end
end
