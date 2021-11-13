defmodule ApiWeb.Plugs.DeviceAuth do
  import Plug.Conn

  alias Api.Automation
  alias Dbstore.Device

  require Logger

  def init(opts \\ :ok), do: opts

  def call(conn, _opts) do
      device_id = conn.params["device_id"]
      with {:get_device, %Device{} = device} <- {:get_device, Automation.get_device(device_id)} do
       conn
       |> put_private(:device, device)
      else
        {:get_device, nil} -> {:error, :not_found}
      end
  end
end
