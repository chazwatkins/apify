defmodule Apify.Webhooks.WebhookDispatches do
  @moduledoc """
  Provides API endpoints related to webhooks/webhook dispatches
  """

  @default_client Apify.Client

  @doc """
  Get webhook dispatch

  Gets webhook dispatch object with all details.
  """
  @spec webhook_dispatch_get(dispatchId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetWebhookDispatchResponse.t()} | {:error, Apify.Error.t()}
  def webhook_dispatch_get(dispatchId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [dispatchId: dispatchId],
      call: {Apify.Webhooks.WebhookDispatches, :webhook_dispatch_get},
      url: "/v2/webhook-dispatches/#{dispatchId}",
      method: :get,
      response: [{200, {Apify.GetWebhookDispatchResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of webhook dispatches

  Gets the list of webhook dispatches that the user have.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 records.
  By default, the records are sorted by the `createdAt` field in ascending
  order. To sort the records in descending order, use the `desc=1`
  parameter.


  ## Options

    * `offset`: Number of records that should be skipped at the start. The default value
      is `0`.
      
    * `limit`: Maximum number of records to return. The default value as well as the
      maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `createdAt` field in
      descending order. By default, they are sorted in ascending order.
      

  """
  @spec webhook_dispatches_get(opts :: keyword) ::
          {:ok, Apify.WebhookDispatchList.t()} | {:error, Apify.Error.t()}
  def webhook_dispatches_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [],
      call: {Apify.Webhooks.WebhookDispatches, :webhook_dispatches_get},
      url: "/v2/webhook-dispatches",
      method: :get,
      query: query,
      response: [{200, {Apify.WebhookDispatchList, :t}}],
      opts: opts
    })
  end
end
