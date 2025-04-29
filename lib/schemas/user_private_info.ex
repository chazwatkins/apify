defmodule Apify.UserPrivateInfo do
  @moduledoc """
  Provides struct and type for a UserPrivateInfo
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          email: String.t(),
          id: String.t(),
          plan: Apify.Plan.t(),
          profile: Apify.Profile.t(),
          proxy: Apify.Proxy.t(),
          username: String.t()
        }

  defstruct [:__info__, :email, :id, :plan, :profile, :proxy, :username]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      email: {:string, :generic},
      id: {:string, :generic},
      plan: {Apify.Plan, :t},
      profile: {Apify.Profile, :t},
      proxy: {Apify.Proxy, :t},
      username: {:string, :generic}
    ]
  end
end
