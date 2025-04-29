defmodule Apify.UserPublicInfo do
  @moduledoc """
  Provides struct and type for a UserPublicInfo
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, profile: Apify.Profile.t(), username: String.t()}

  defstruct [:__info__, :profile, :username]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [profile: {Apify.Profile, :t}, username: {:string, :generic}]
  end
end
