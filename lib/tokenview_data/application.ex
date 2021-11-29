defmodule TokenviewData.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias TokenviewData.Config

  require Logger

  @impl true
  def start(_type, _args) do
    children = []

    children =
      if Config.builtin_webhook() do
        port = Config.webhook_server_port()

        Logger.info("Running TokenviewData.WebhookRouter at 0.0.0.0:#{port} (http)")

        children ++
          [{Plug.Cowboy, scheme: :http, plug: TokenviewData.WebhookRouter, options: [port: port]}]
      else
        children
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TokenviewData.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
