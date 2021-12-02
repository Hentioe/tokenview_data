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
  获取 Webhook URL。
  """
  def get_webhook_url do
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
  获取已跟踪的地址列表。
  """
  def get_tracked_addresses_list(coin_abbr, page \\ 1) do
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
    endpoint = "https://services.tokenview.com/vipapi/addr/b/#{coin_abbr}/#{address_hash}"

    Request.call(:api, endpoint, :get)
  end
end
