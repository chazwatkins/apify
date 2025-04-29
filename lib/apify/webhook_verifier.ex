defmodule Apify.WebhookVerifier do
  @moduledoc """
  Utilities for working with Apify webhooks

  This module provides functions for verifying and processing Apify webhooks.
  """

  @doc """
  Verify a webhook request signature

  This function verifies that a webhook request was signed with the expected secret.
  It compares the signature in the request headers with a computed signature of the
  request body.

  ## Parameters

  * `body` - The raw request body as a binary
  * `headers` - A map or keyword list of request headers
  * `secret` - The webhook secret used to sign the request

  ## Examples

      iex> WebhookVerifier.verify(conn.body_params, conn.req_headers, "webhook-secret")
      :ok

      iex> WebhookVerifier.verify(conn.body_params, conn.req_headers, "wrong-secret")
      {:error, :invalid_signature}

  """
  @spec verify(binary, map | keyword, String.t()) ::
          :ok | {:error, :invalid_signature | :missing_signature}
  def verify(body, headers, secret) when is_binary(body) and is_binary(secret) do
    case get_signature_header(headers) do
      nil ->
        {:error, :missing_signature}

      signature ->
        expected = compute_signature(body, secret)

        if Plug.Crypto.secure_compare(signature, expected) do
          :ok
        else
          {:error, :invalid_signature}
        end
    end
  end

  @doc """
  Parse a webhook payload

  This function parses a webhook payload into a structured format. It extracts the
  event type and data from the payload.

  ## Parameters

  * `body` - The request body as a map

  ## Examples

      iex> WebhookVerifier.parse(%{"eventType" => "ACTOR.RUN.SUCCEEDED", "data" => %{"actorId" => "abc123"}})
      {:ok, %{event: "ACTOR.RUN.SUCCEEDED", data: %{"actorId" => "abc123"}}}

  """
  @spec parse(map) :: {:ok, map} | {:error, :invalid_payload}
  def parse(%{"eventType" => event_type, "data" => data}) do
    {:ok, %{event: event_type, data: data}}
  end

  def parse(_) do
    {:error, :invalid_payload}
  end

  # Private helpers

  defp get_signature_header(headers) when is_map(headers) do
    headers["x-apify-webhook-signature"]
  end

  defp get_signature_header(headers) when is_list(headers) do
    case List.keyfind(headers, "x-apify-webhook-signature", 0) do
      {_, value} -> value
      nil -> nil
    end
  end

  defp compute_signature(body, secret) do
    :crypto.mac(:hmac, :sha256, secret, body)
    |> Base.encode16(case: :lower)
  end
end
