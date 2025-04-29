defmodule Apify.Profile do
  @moduledoc """
  Provides struct and type for a Profile
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          bio: String.t() | nil,
          githubUsername: String.t() | nil,
          name: String.t() | nil,
          pictureUrl: String.t() | nil,
          twitterUsername: String.t() | nil,
          websiteUrl: String.t() | nil
        }

  defstruct [:__info__, :bio, :githubUsername, :name, :pictureUrl, :twitterUsername, :websiteUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bio: {:string, :generic},
      githubUsername: {:string, :generic},
      name: {:string, :generic},
      pictureUrl: {:string, :generic},
      twitterUsername: {:string, :generic},
      websiteUrl: {:string, :generic}
    ]
  end
end
