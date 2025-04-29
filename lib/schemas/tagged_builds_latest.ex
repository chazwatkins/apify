defmodule Apify.TaggedBuildsLatest do
  @moduledoc """
  Provides struct and type for a TaggedBuildsLatest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          buildId: String.t() | nil,
          buildNumber: String.t() | nil,
          finishedAt: String.t() | nil
        }

  defstruct [:__info__, :buildId, :buildNumber, :finishedAt]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      buildId: {:string, :generic},
      buildNumber: {:string, :generic},
      finishedAt: {:string, :generic}
    ]
  end
end
