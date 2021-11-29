defmodule TokenviewData do
  @moduledoc false

  alias TokenviewData.Request

  @doc """
  设置 Webhook URL。
  """
  def set_webhook_url(server_url) do
    endpoint = "https://services.tokenview.com/vipapi/monitor/setwebhookurl"

    Request.call(:address_tracking, endpoint, {:post, :raw}, body: server_url)
  end

  @doc """
  查看 Webhook URL。
  """
  def review_webhook_url do
    endpoint = "https://services.tokenview.com/vipapi/monitor/getwebhookurl"

    Request.call(:address_tracking, endpoint, :get)
  end

  @doc """
  添加订阅地址。
  """
  def add_subscription_address(coin_abbr, address_hash) do
    endpoint =
      "https://services.tokenview.com/vipapi/monitor/address/add/#{coin_abbr}/#{address_hash}"

    Request.call(:address_tracking, endpoint, :get)
  end

  @doc """
  查看已跟踪的地址列表。
  """
  def review_tracked_addresses_list(coin_abbr, page \\ 1) do
    endpoint =
      "https://services.tokenview.com/vipapi/monitor/address/list/#{coin_abbr}?page=#{page}"

    Request.call(:address_tracking, endpoint, :get, append_key: true)
  end

  @doc """
  删除正在跟踪的地址。
  """
  def delete_tracking_address(coin_abbr, address_hash) do
    endpoint =
      "https://services.tokenview.com/vipapi/monitor/address/remove/#{coin_abbr}/#{address_hash}"

    Request.call(:address_tracking, endpoint, :get)
  end

  @doc """
  地址余额。
  """
  def address_balance(coin_abbr, address_hash) do
    endpoint = "https://services.tokenview.com/vipapi/address/#{coin_abbr}/#{address_hash}/1/1"

    Request.call(:api, endpoint, :get)
  end
end
