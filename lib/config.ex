defmodule TokenviewData.Config do
  @moduledoc false

  @spec key :: String.t()
  def key() do
    get(:key)
  end

  @spec builtin_webhook :: boolean()
  def builtin_webhook() do
    get(:builtin_webhook)
  end

  @spec webhook_server_port :: integer
  def webhook_server_port() do
    get(:webhook_server_port)
  end

  @spec get(atom) :: any
  def get(key) do
    Application.get_env(:tokenview_data, key)
  end
end
