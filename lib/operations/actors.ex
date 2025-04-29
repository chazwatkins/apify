defmodule Apify.Actors do
  @moduledoc """
  Provides API endpoints related to actors
  """

  @default_client Apify.Client

  @doc """
  Delete Actor

  Deletes an Actor.
  """
  @spec act_delete(actorId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def act_delete(actorId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors, :act_delete},
      url: "/v2/acts/#{actorId}",
      method: :delete,
      response: [{204, :map}],
      opts: opts
    })
  end

  @doc """
  Get Actor

  Gets an object that contains all the details about a specific Actor.
  """
  @spec act_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetActorResponse.t()} | {:error, Apify.Error.t()}
  def act_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors, :act_get},
      url: "/v2/acts/#{actorId}",
      method: :get,
      response: [{200, {Apify.GetActorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Update Actor

  Updates settings of an Actor using values specified by an Actor object
  passed as JSON in the POST payload.
  If the object does not define a specific property, its value will not be
  updated.

  The response is the full Actor object as returned by the
  [Get Actor](#/reference/actors/actor-object/get-actor) endpoint.

  The request needs to specify the `Content-Type: application/json` HTTP header!

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  If you want to make your Actor
  [public](https://docs.apify.com/platform/actors/publishing) using `isPublic:
  true`, you will need to provide the Actor's `title` and the `categories`
  under which that Actor will be classified in Apify Store. For this, it's
  best to use the [constants from our `apify-shared-js`
  package](https://github.com/apify/apify-shared-js/blob/2d43ebc41ece9ad31cd6525bd523fb86939bf860/packages/consts/src/consts.ts#L452-L471).

  """
  @spec act_put(actorId :: String.t(), body :: Apify.UpdateActorRequest.t(), opts :: keyword) ::
          {:ok, Apify.UpdateActorResponse.t()} | {:error, Apify.Error.t()}
  def act_put(actorId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, body: body],
      call: {Apify.Actors, :act_put},
      url: "/v2/acts/#{actorId}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.UpdateActorRequest, :t}}],
      response: [{200, {Apify.UpdateActorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of Actors

  Gets the list of all Actors that the user created or used. The response is a
  list of objects, where each object contains a basic information about a single Actor.

  To only get Actors created by the user, add the `my=1` query parameter.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 records.

  By default, the records are sorted by the `createdAt` field in ascending
  order, therefore you can use pagination to incrementally fetch all Actors while new
  ones are still being created. To sort the records in descending order, use the `desc=1` parameter.


  ## Options

    * `my`: If `true` or `1` then the returned list only contains Actors owned by the user. The default value is `false`.
      
    * `offset`: Number of records that should be skipped at the start. The default value
      is `0`.
      
    * `limit`: Maximum number of records to return. The default value as well as the
      maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `createdAt` field in
      descending order. By default, they are sorted in ascending order.
      

  """
  @spec acts_get(opts :: keyword) ::
          {:ok, Apify.GetListOfActorsResponse.t()} | {:error, Apify.Error.t()}
  def acts_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :my, :offset])

    client.request(%{
      args: [],
      call: {Apify.Actors, :acts_get},
      url: "/v2/acts",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfActorsResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Create Actor

  Creates a new Actor with settings specified in an Actor object passed as
  JSON in the POST payload.
  The response is the full Actor object as returned by the
  [Get Actor](#/reference/actors/actor-object/get-actor) endpoint.

  The HTTP request must have the `Content-Type: application/json` HTTP header!

  The Actor needs to define at least one version of the source code.
  For more information, see [Version object](#/reference/actors/version-object).

  If you want to make your Actor
  [public](https://docs.apify.com/platform/actors/publishing) using `isPublic:
  true`, you will need to provide the Actor's `title` and the `categories`
  under which that Actor will be classified in Apify Store. For this, it's
  best to use the [constants from our `apify-shared-js`
  package](https://github.com/apify/apify-shared-js/blob/2d43ebc41ece9ad31cd6525bd523fb86939bf860/packages/consts/src/consts.ts#L452-L471).

  """
  @spec acts_post(body :: Apify.CreateActorRequest.t(), opts :: keyword) ::
          {:ok, Apify.CreateActorResponse.t()} | {:error, Apify.Error.t()}
  def acts_post(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Apify.Actors, :acts_post},
      url: "/v2/acts",
      body: body,
      method: :post,
      request: [{"application/json", {Apify.CreateActorRequest, :t}}],
      response: [{201, {Apify.CreateActorResponse, :t}}],
      opts: opts
    })
  end
end
