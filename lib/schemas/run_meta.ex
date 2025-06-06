defmodule Apify.RunMeta do
  @moduledoc """
  Provides struct and type for a RunMeta
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, origin: String.t()}

  defstruct [:__info__, :origin]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      origin:
        {:enum,
         ["DEVELOPMENT", "WEB", "API", "SCHEDULER", "TEST", "WEBHOOK", "ACTOR", "CLI", "STANDBY"]}
    ]
  end
end
