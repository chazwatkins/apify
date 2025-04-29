defmodule Apify.Actors.WebhookCollection do
  @moduledoc """
  Provides API endpoint related to actors/webhook collection
  """

  @default_client Apify.Client

  @doc """
  Get list of webhooks

  Gets the list of webhooks of a specific Actor. The response is a JSON with
  the list of objects, where each object contains basic information about a single webhook.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 records.

  By default, the records are sorted by the `createdAt` field in ascending
  order, to sort the records in descending order, use the `desc=1` parameter.


  ## Options

    * `offset`: Number of array elements that should be skipped at the start. The
      default value is `0`.
      
    * `limit`: Maximum number of array elements to return. The default value as well as
      the maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `createdAt` field in
      descending order. By default, they are sorted in ascending order.
      

  """
  @spec act_webhooks_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetListOfWebhooksResponse.t()} | {:error, Apify.Error.t()}
  def act_webhooks_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.WebhookCollection, :act_webhooks_get},
      url: "/v2/acts/#{actorId}/webhooks",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfWebhooksResponse, :t}}],
      opts: opts
    })
  end
end
