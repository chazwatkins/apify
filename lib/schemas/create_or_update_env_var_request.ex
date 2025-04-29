defmodule Apify.CreateOrUpdateEnvVarRequest do
  @moduledoc """
  Provides struct and type for a CreateOrUpdateEnvVarRequest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          isSecret: boolean | nil,
          name: String.t(),
          value: String.t()
        }

  defstruct [:__info__, :isSecret, :name, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [isSecret: :boolean, name: {:string, :generic}, value: {:string, :generic}]
  end
end
