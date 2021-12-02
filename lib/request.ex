defmodule TokenviewData.Request do
  @moduledoc false

  alias TokenviewData.Config
  alias TokenviewData.Models.{Response, ApiError, RequestError}

  @type error :: ApiError.t() | RequestError.t()
  @type key_category :: :address_tracking | :api
  @type method :: :post | :get
  @type content_type :: :raw

  @spec call(key_category, String.t(), {method, content_type} | method, keyword) ::
          {:ok, Response.t()} | {:error, error}

  def call(key_category, endpoint, mc, opts \\ [])

  def call(key_category, endpoint, {:post, :raw}, opts) do
    body = Keyword.get(opts, :body)
    endpoint = preprocessing_endpoint(key_category, endpoint, opts)

    endpoint
    |> HTTPoison.post(body)
    |> handle_httpsion_returns()
  end

  def call(key_category, endpoint, :get, opts) do
    endpoint = preprocessing_endpoint(key_category, endpoint, opts)

    endpoint
    |> HTTPoison.get()
    |> handle_httpsion_returns()
  end

  @spec key(key_category) :: String.t()
  defp key(category) do
    case category do
      :address_tracking -> Config.address_track_key()
      :api -> Config.api_key()
      _ -> raise "Unknown key category: `#{category}`"
    end
  end

  @spec preprocessing_endpoint(key_category, String.t(), keyword) :: String.t()
  defp preprocessing_endpoint(key_category, endpoint, opts) do
    append_key = Keyword.get(opts, :append_key, false)

    if append_key do
      "#{endpoint}&apikey=#{key(key_category)}"
    else
      "#{endpoint}?apikey=#{key(key_category)}"
    end
  end

  @spec handle_httpsion_returns({:ok, HTTPoison.Response.t()} | {:error, error}) ::
          {:ok, Response.t()} | {:error, error}
  defp handle_httpsion_returns({:ok, resp}) do
    status_code = resp.status_code

    if status_code in [200] do
      body_json = Jason.decode!(resp.body)

      code = body_json["code"]
      msg = body_json["msg"]
      data = body_json["data"]

      if code == 1 do
        {:ok, %Response{status_code: status_code, code: code, msg: msg, data: data}}
      else
        {:error, %ApiError{code: code, msg: msg}}
      end
    else
      {:error, %ApiError{code: 401, msg: "HTTP Status: #{status_code}"}}
    end
  end

  defp handle_httpsion_returns({:error, err}) do
    {:error, %RequestError{reason: err.reason, msg: HTTPoison.Error.message(err)}}
  end
end
