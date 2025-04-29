defmodule Apify.Schedules do
  @moduledoc """
  Provides API endpoints related to schedules
  """

  @default_client Apify.Client

  @doc """
  Delete schedule

  Deletes a schedule.
  """
  @spec schedule_delete(scheduleId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def schedule_delete(scheduleId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [scheduleId: scheduleId],
      call: {Apify.Schedules, :schedule_delete},
      url: "/v2/schedules/#{scheduleId}",
      method: :delete,
      response: [{204, :map}],
      opts: opts
    })
  end

  @doc """
  Get schedule

  Gets the schedule object with all details.
  """
  @spec schedule_get(scheduleId :: String.t(), opts :: keyword) ::
          {:ok, Apify.ScheduleResponse.t()} | {:error, Apify.Error.t()}
  def schedule_get(scheduleId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [scheduleId: scheduleId],
      call: {Apify.Schedules, :schedule_get},
      url: "/v2/schedules/#{scheduleId}",
      method: :get,
      response: [{200, {Apify.ScheduleResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get schedule log

  Gets the schedule log as a JSON array containing information about up to a
  1000 invocations of the schedule.

  """
  @spec schedule_log_get(scheduleId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetScheduleLogResponse.t()} | {:error, Apify.Error.t()}
  def schedule_log_get(scheduleId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [scheduleId: scheduleId],
      call: {Apify.Schedules, :schedule_log_get},
      url: "/v2/schedules/#{scheduleId}/log",
      method: :get,
      response: [{200, {Apify.GetScheduleLogResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Update schedule

  Updates a schedule using values specified by a schedule object passed as
  JSON in the POST payload. If the object does not define a specific property,
  its value will not be updated.

  The response is the full schedule object as returned by the
  [Get schedule](#/reference/schedules/schedule-object/get-schedule) endpoint.

  **The request needs to specify the `Content-Type: application/json` HTTP
  header!**

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  """
  @spec schedule_put(scheduleId :: String.t(), body :: Apify.ScheduleCreate.t(), opts :: keyword) ::
          {:ok, Apify.ScheduleResponse.t()} | {:error, Apify.Error.t()}
  def schedule_put(scheduleId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [scheduleId: scheduleId, body: body],
      call: {Apify.Schedules, :schedule_put},
      url: "/v2/schedules/#{scheduleId}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.ScheduleCreate, :t}}],
      response: [{200, {Apify.ScheduleResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of schedules

  Gets the list of schedules that the user created.

  The endpoint supports pagination using the `limit` and `offset` parameters.
  It will not return more than 1000 records.

  By default, the records are sorted by the `createdAt` field in ascending
  order. To sort the records in descending order, use the `desc=1` parameter.


  ## Options

    * `offset`: Number of records that should be skipped at the start. The default value is `0`.
      
    * `limit`: Maximum number of records to return. The default value, as well as the maximum, is `1000`.
      
    * `desc`: If `true` or `1`, the objects are sorted by the `createdAt` field in
      descending order. By default, they are sorted in ascending order.
      

  """
  @spec schedules_get(opts :: keyword) ::
          {:ok, Apify.GetListOfSchedulesResponse.t()} | {:error, Apify.Error.t()}
  def schedules_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [],
      call: {Apify.Schedules, :schedules_get},
      url: "/v2/schedules",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfSchedulesResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Create schedule

  Creates a new schedule with settings provided by the schedule object passed
  as JSON in the payload. The response is the created schedule object.

  The request needs to specify the `Content-Type: application/json` HTTP header!

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  """
  @spec schedules_post(body :: Apify.ScheduleCreate.t(), opts :: keyword) ::
          {:ok, Apify.ScheduleResponse.t()} | {:error, Apify.Error.t()}
  def schedules_post(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Apify.Schedules, :schedules_post},
      url: "/v2/schedules",
      body: body,
      method: :post,
      request: [{"application/json", {Apify.ScheduleCreate, :t}}],
      response: [{201, {Apify.ScheduleResponse, :t}}],
      opts: opts
    })
  end
end
