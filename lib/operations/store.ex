defmodule Apify.Store do
  @moduledoc """
  Provides API endpoint related to store
  """

  @default_client Apify.Client

  @doc """
  Get list of Actors in store

  Gets the list of public Actors in Apify Store. You can use `search`
  parameter to search Actors by string in title, name, description, username
  and readme.
  If you need detailed info about a specific Actor, use the [Get
  Actor](#/reference/actors/actor-object/get-actor) endpoint.

  The endpoint supports pagination using the `limit` and `offset` parameters.
  It will not return more than 1,000 records.


  ## Options

    * `limit`: Maximum number of elements to return. The default and maximum value is
      `1,000`.
      
    * `offset`: Number of elements that should be skipped at the start. The default
      value is `0`.
      
    * `search`: String to search by. The search runs on the following fields: `title`,
      `name`, `description`, `username`, `readme`.
      
    * `sortBy`: Specifies the field by which to sort the results. The supported values
      are `relevance` (default), `popularity`, `newest` and `lastUpdate`.
      
    * `category`: Filters the results by the specified category.
    * `username`: Filters the results by the specified username.
    * `pricingModel`: Filters the results by the specified pricing model. The supported values
      are `FREE`, `FLAT_PRICE_PER_MONTH` and `PRICE_PER_DATASET_ITEM`.
      

  """
  @spec store_get(opts :: keyword) ::
          {:ok, Apify.GetListOfActorsInStoreResponse.t()} | {:error, Apify.Error.t()}
  def store_get(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:category, :limit, :offset, :pricingModel, :search, :sortBy, :username])

    client.request(%{
      args: [],
      call: {Apify.Store, :store_get},
      url: "/v2/store",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfActorsInStoreResponse, :t}}],
      opts: opts
    })
  end
end
