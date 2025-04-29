defmodule Apify.TestingTest do
  use ExUnit.Case

  test "testing module exists" do
    assert Code.ensure_loaded?(Apify.Testing)
  end
end
