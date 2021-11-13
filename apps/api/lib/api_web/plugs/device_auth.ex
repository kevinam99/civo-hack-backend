defmodule ApiWeb.Plugs.DeviceAuth do
  import Plug.Conn

  alias Api.Automations
  alias Dbstore.Device

  require Logger

  def init(opts \\ :ok), do: opts

  def call(conn, _opts) do
    device_id = conn.params["device_id"]

    with {:get_device, %Device{} = device} <- {:get_device, Automations.get_device(device_id)} do
      conn
      |> put_private(:device, device)
    else
      {:get_device, nil} -> handle_failure(conn, "Device not found")
    end
  end

  defp handle_failure(conn, err_msg) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(
      :unauthorized,
      Jason.encode!(%{error: err_msg})
    )
    |> halt()
  end
end
