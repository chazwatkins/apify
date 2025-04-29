defmodule Apify.Users do
  @moduledoc """
  Provides API endpoints related to users
  """

  @default_client Apify.Client

  @doc """
  Get public user data

  Returns public information about a specific user account, similar to what
  can be seen on public profile pages (e.g. https://apify.com/apify).

  This operation requires no authentication token.

  """
  @spec user_get(userId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetPublicUserDataResponse.t()} | {:error, Apify.Error.t()}
  def user_get(userId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [userId: userId],
      call: {Apify.Users, :user_get},
      url: "/v2/users/#{userId}",
      method: :get,
      response: [{200, {Apify.GetPublicUserDataResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get private user data

  Returns information about the current user account, including both public
  and private information.

  The user account is identified by the provided authentication token.

  The fields `plan`, `email` and `profile` are omitted when this endpoint is accessed from Actor run.

  """
  @spec users_me_get(opts :: keyword) ::
          {:ok, Apify.GetPrivateUserDataResponse.t()} | {:error, Apify.Error.t()}
  def users_me_get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Apify.Users, :users_me_get},
      url: "/v2/users/me",
      method: :get,
      response: [{200, {Apify.GetPrivateUserDataResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get limits

  Returns a complete summary of your account's limits. It is the same
  information you will see on your account's [Limits page](https://console.apify.com/billing#/limits). The returned data
  includes the current usage cycle, a summary of your limits, and your current usage.

  """
  @spec users_me_limits_get(opts :: keyword) ::
          {:ok, Apify.GetLimitsResponse.t()} | {:error, Apify.Error.t()}
  def users_me_limits_get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Apify.Users, :users_me_limits_get},
      url: "/v2/users/me/limits",
      method: :get,
      response: [{200, {Apify.GetLimitsResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Update limits

  Updates the account's limits manageable on your account's [Limits page](https://console.apify.com/billing#/limits).
  Specifically the: `maxMonthlyUsageUsd` and `dataRetentionDays` limits (see request body schema for more details).

  """
  @spec users_me_limits_put(body :: Apify.UpdateLimitsRequest.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def users_me_limits_put(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Apify.Users, :users_me_limits_put},
      url: "/v2/users/me/limits",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.UpdateLimitsRequest, :t}}],
      response: [{201, :map}],
      opts: opts
    })
  end

  @doc """
  Get monthly usage

  Returns a complete summary of your usage for the current usage cycle,
  an overall sum, as well as a daily breakdown of usage. It is the same
  information you will see on your account's [Billing page](https://console.apify.com/billing#/usage). The information
  includes your use of storage, data transfer, and request queue usage.

  Using the `date` parameter will show your usage in the usage cycle that
  includes that date.


  ## Options

    * `date`: Date in the YYYY-MM-DD format.

  """
  @spec users_me_usage_monthly_get(opts :: keyword) ::
          {:ok, Apify.GetMonthlyUsageResponse.t()} | {:error, Apify.Error.t()}
  def users_me_usage_monthly_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:date])

    client.request(%{
      args: [],
      call: {Apify.Users, :users_me_usage_monthly_get},
      url: "/v2/users/me/usage/monthly",
      method: :get,
      query: query,
      response: [{200, {Apify.GetMonthlyUsageResponse, :t}}],
      opts: opts
    })
  end
end
