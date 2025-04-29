defmodule ApifyTest do
  use ExUnit.Case

  alias Apify.Config
  alias Apify.Operation

  doctest Apify.Config, except: [stack: 1]
  doctest Apify.Operation

  test "client creation" do
    client = Apify.client(api_token: "test-token")
    assert client == Apify.Client
  end
end
