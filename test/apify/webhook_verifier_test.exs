defmodule Apify.WebhookVerifierTest do
  use ExUnit.Case

  alias Apify.WebhookVerifier

  describe "verify/3" do
    test "requires signature header" do
      body = "{}"
      headers = []
      
      assert {:error, :missing_signature} = WebhookVerifier.verify(body, headers, "test-secret")
    end

    test "requires valid signature" do
      body = "{}"
      headers = [{"x-apify-webhook-signature", "invalid-signature"}]
      
      assert {:error, :invalid_signature} = WebhookVerifier.verify(body, headers, "test-secret")
    end

    test "passes with valid signature" do
      body = "{}"
      
      signature = :crypto.mac(:hmac, :sha256, "test-secret", body)
                  |> Base.encode16(case: :lower)
      
      headers = [{"x-apify-webhook-signature", signature}]
      
      assert :ok = WebhookVerifier.verify(body, headers, "test-secret")
    end
  end

  describe "parse/1" do
    test "parses valid webhook payload" do
      payload = %{"eventType" => "ACTOR.RUN.SUCCEEDED", "data" => %{"actorId" => "test-actor-id"}}
      
      assert {:ok, %{event: "ACTOR.RUN.SUCCEEDED", data: %{"actorId" => "test-actor-id"}}} = 
        WebhookVerifier.parse(payload)
    end

    test "returns error for invalid payload" do
      payload = %{"invalid" => "payload"}
      
      assert {:error, :invalid_payload} = WebhookVerifier.parse(payload)
    end
  end
end
