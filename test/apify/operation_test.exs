defmodule Apify.OperationTest do
  use ExUnit.Case

  alias Apify.Operation

  describe "new/1" do
    setup do
      %{
        info: %{
          url: "/v2/actor-runs/test-run-id",
          method: :get,
          response: [{200, :map}],
          opts: []
        }
      }
    end

    test "includes default auth header", %{info: info} do
      operation = Operation.new(info)
      
      assert Enum.find(operation.request_headers, fn {name, value} ->
               name == "Authorization" and
                 value == "Bearer #{Apify.Config.default_auth()}"
             end)
    end

    test "includes custom auth header", %{info: info} do
      operation = Operation.new(%{info | opts: [auth: "test-token"]})

      assert Enum.find(operation.request_headers, fn {name, value} ->
               name == "Authorization" and
                 value == "Bearer test-token"
             end)
    end

    test "includes content type", %{info: info} do
      operation = Operation.new(Map.put(info, :request, [{"application/json", nil}]))

      assert Enum.find(operation.request_headers, fn {name, value} ->
               name == "Content-Type" and
                 value == "application/json"
             end)
    end

    test "includes user agent", %{info: info} do
      operation = Operation.new(info)

      assert Enum.find(operation.request_headers, fn {name, value} ->
               name == "User-Agent" and
                 value =~ "via apify_client"
             end)
    end
  end
end
