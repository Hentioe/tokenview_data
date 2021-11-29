defmodule TokenviewData.WebhookRouter do
  @moduledoc false

  use Plug.Router

  require Logger

  alias TokenviewData.Config

  plug :match
  plug :dispatch

  post "/webhook" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    Logger.debug("Read the original body from webhook: #{inspect(body)}")

    data = Jason.decode!(body)

    if hook = Config.hook() do
      Logger.info("Forward the data `#{inspect(data)}` to the hook module `#{hook}`")

      hook.call(data)
    else
      Logger.warn("Missing hook module, ignore forwarding")
    end

    send_resp(conn, 200, "OK")
  end

  get "/webhook" do
    send_resp(conn, 200, "RUNNING IN BUILTING")
  end
end
