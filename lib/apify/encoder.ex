defmodule Apify.Encoder do
  @moduledoc """
  Encoder for Apify API requests

  This module provides a macro for deriving Jason.Encoder for Apify structs.
  """

  defmacro __using__(_opts) do
    quote do
      @derive {Jason.Encoder, except: [:__info__]}
    end
  end
end
