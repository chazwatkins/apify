defmodule Apify.Proxy do
  @moduledoc """
  Provides struct and type for a Proxy
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, groups: [Apify.ProxyGroup.t()], password: String.t()}

  defstruct [:__info__, :groups, :password]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [groups: [{Apify.ProxyGroup, :t}], password: {:string, :generic}]
  end
end
