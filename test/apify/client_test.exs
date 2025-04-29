defmodule Apify.ClientTest do
  use ExUnit.Case, async: true

  test "client exists" do
    assert Code.ensure_loaded?(Apify.Client)
  end
end
