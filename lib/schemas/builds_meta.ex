defmodule Apify.BuildsMeta do
  @moduledoc """
  Provides struct and type for a BuildsMeta
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          clientIp: String.t(),
          origin: String.t(),
          userAgent: String.t()
        }

  defstruct [:__info__, :clientIp, :origin, :userAgent]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [clientIp: {:string, :generic}, origin: {:string, :generic}, userAgent: {:string, :generic}]
  end
end
