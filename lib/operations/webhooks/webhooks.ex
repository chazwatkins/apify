defmodule Apify.Webhooks.Webhooks do
  @moduledoc """
  Provides API endpoints related to webhooks/webhooks
  """

  @default_client Apify.Client

  @doc """
  Delete webhook

  Deletes a webhook.
  """
  @spec webhook_delete(webhookId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def webhook_delete(webhookId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [webhookId: webhookId],
      call: {Apify.Webhooks.Webhooks, :webhook_delete},
      url: "/v2/webhooks/#{webhookId}",
      method: :delete,
      response: [{204, :map}],
      opts: opts
    })
  end

  @doc """
  Get collection

  Gets a given webhook's list of dispatches.
  """
  @spec webhook_dispatches_get(webhookId :: String.t(), opts :: keyword) ::
          {:ok, Apify.WebhookDispatchList.t()} | {:error, Apify.Error.t()}
  def webhook_dispatches_get(webhookId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [webhookId: webhookId],
      call: {Apify.Webhooks.Webhooks, :webhook_dispatches_get},
      url: "/v2/webhooks/#{webhookId}/dispatches",
      method: :get,
      response: [{200, {Apify.WebhookDispatchList, :t}}],
      opts: opts
    })
  end

  @doc """
  Get webhook

  Gets webhook object with all details.
  """
  @spec webhook_get(webhookId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetWebhookResponse.t()} | {:error, Apify.Error.t()}
  def webhook_get(webhookId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [webhookId: webhookId],
      call: {Apify.Webhooks.Webhooks, :webhook_get},
      url: "/v2/webhooks/#{webhookId}",
      method: :get,
      response: [{200, {Apify.GetWebhookResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Update webhook

  Updates a webhook using values specified by a webhook object passed as JSON
  in the POST payload.
  If the object does not define a specific property, its value will not be
  updated.

  The response is the full webhook object as returned by the
  [Get webhook](#/reference/webhooks/webhook-object/get-webhook) endpoint.

  The request needs to specify the `Content-Type: application/json` HTTP
  header!

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  """
  @spec webhook_put(webhookId :: String.t(), body :: Apify.WebhookUpdate.t(), opts :: keyword) ::
          {:ok, Apify.UpdateWebhookResponse.t()} | {:error, Apify.Error.t()}
  def webhook_put(webhookId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [webhookId: webhookId, body: body],
      call: {Apify.Webhooks.Webhooks, :webhook_put},
      url: "/v2/webhooks/#{webhookId}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.WebhookUpdate, :t}}],
      response: [{200, {Apify.UpdateWebhookResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Test webhook

  Tests a webhook. Creates a webhook dispatch with a dummy payload.
  """
  @spec webhook_test_post(webhookId :: String.t(), opts :: keyword) ::
          {:ok, Apify.TestWebhookResponse.t()} | {:error, Apify.Error.t()}
  def webhook_test_post(webhookId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [webhookId: webhookId],
      call: {Apify.Webhooks.Webhooks, :webhook_test_post},
      url: "/v2/webhooks/#{webhookId}/test",
      method: :post,
      response: [{201, {Apify.TestWebhookResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of webhooks

  Gets the list of webhooks that the user created.

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
  @spec webhooks_get(opts :: keyword) ::
          {:ok, Apify.GetListOfWebhooksResponse.t()} | {:error, Apify.Error.t()}
  def webhooks_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [],
      call: {Apify.Webhooks.Webhooks, :webhooks_get},
      url: "/v2/webhooks",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfWebhooksResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Create webhook

  Creates a new webhook with settings provided by the webhook object passed as
  JSON in the payload.
  The response is the created webhook object.

  To avoid duplicating a webhook, use the `idempotencyKey` parameter in the
  request body.
  Multiple calls to create a webhook with the same `idempotencyKey` will only
  create the webhook with the first call and return the existing webhook on
  subsequent calls.
  Idempotency keys must be unique, so use a UUID or another random string with
  enough entropy.

  To assign the new webhook to an Actor or task, the request body must contain
  `requestUrl`, `eventTypes`, and `condition` properties.

  * `requestUrl` is the webhook's target URL, to which data is sent as a POST
  request with a JSON payload.
  * `eventTypes` is a list of events that will trigger the webhook, e.g. when
  the Actor run succeeds.
  * `condition` should be an object containing the ID of the Actor or task to
  which the webhook will be assigned.
  * `payloadTemplate` is a JSON-like string, whose syntax is extended with the
  use of variables.
  * `headersTemplate` is a JSON-like string, whose syntax is extended with the
  use of variables. Following values will be re-written to defaults: "host",
  "Content-Type", "X-Apify-Webhook", "X-Apify-Webhook-Dispatch-Id",
  "X-Apify-Request-Origin"
  * `description` is an optional string.
  * `shouldInterpolateStrings` is a boolean indicating whether to interpolate
  variables contained inside strings in the `payloadTemplate`

  ```
      "isAdHoc" : false,
      "requestUrl" : "https://example.com",
      "eventTypes" : [
          "ACTOR.RUN.SUCCEEDED",
          "ACTOR.RUN.ABORTED"
      ],
      "condition" : {
          "actorId": "janedoe~my-actor",
          "actorTaskId" : "W9bs9JE9v7wprjAnJ"
      },
      "payloadTemplate": "",
      "headersTemplate": "",
      "description": "my awesome webhook",
      "shouldInterpolateStrings": false,
  ```

  **Important**: The request must specify the `Content-Type: application/json`
  HTTP header.


  ## Options

    * `limit`: 
    * `offset`: 
    * `desc`: 

  """
  @spec webhooks_post(body :: Apify.WebhookCreate.t(), opts :: keyword) ::
          {:ok, Apify.CreateWebhookResponse.t()} | {:error, Apify.Error.t()}
  def webhooks_post(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [body: body],
      call: {Apify.Webhooks.Webhooks, :webhooks_post},
      url: "/v2/webhooks",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Apify.WebhookCreate, :t}}],
      response: [{201, {Apify.CreateWebhookResponse, :t}}],
      opts: opts
    })
  end
end
