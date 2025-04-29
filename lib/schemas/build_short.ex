defmodule Apify.BuildShort do
  @moduledoc """
  Provides struct and type for a BuildShort
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actId: String.t() | nil,
          finishedAt: String.t(),
          id: String.t(),
          meta: Apify.BuildShortMeta.t() | nil,
          startedAt: String.t(),
          status: String.t(),
          usageTotalUsd: number
        }

  defstruct [:__info__, :actId, :finishedAt, :id, :meta, :startedAt, :status, :usageTotalUsd]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actId: {:string, :generic},
      finishedAt: {:string, :generic},
      id: {:string, :generic},
      meta: {Apify.BuildShortMeta, :t},
      startedAt: {:string, :generic},
      status: {:string, :generic},
      usageTotalUsd: :number
    ]
  end
end
