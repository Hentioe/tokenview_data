defmodule TokenviewData.WebhookRouter do
  @moduledoc false

  use Plug.Router

  require Logger

  plug :match

  plug :dispatch

  post "/webhook" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    Logger.debug("Read the original body from webhook: #{inspect(body)}")

    data = Jason.decode!(body)

    Logger.info("Parse the data from webhook: #{inspect(data)}")

    send_resp(conn, 200, "OK")
  end

  get "/webhook" do
    send_resp(conn, 200, "RUNNING IN BUILTING")
  end
end
