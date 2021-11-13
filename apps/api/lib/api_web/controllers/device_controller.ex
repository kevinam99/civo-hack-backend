defmodule ApiWeb.DeviceController do
  use ApiWeb, :controller

  alias Api.Automation
  alias Dbstore.Device
  def index(conn, _params) do
    devices = Automation.list_devices()

    render(conn, "index.json", devices: devices)
  end

  def show(conn, _params) do
  %Device{} = device = conn.private[:device]

  db_device = Automation.get_device(device.id)
  render(conn, "show.json", device: db_device)

  end

  def create(conn, %{
    "name" => device_name
  }= _params) do

    with {:trim_device_name, device_name} <- {:trim_device_name, String.trim(device_name)},
    {:create_device_check, %Device{} = device} <- {:create_device_check, Automation.create_device(%{name: device_name})} do
    conn
    |> put_status(:created)
    |> render("show.json", device: device)
    else
      {:create_device_check, {:error, %Ecto.Changeset{} = changeset}} -> {:error, :bad_request, "Error while creating the device: #{inspect(changeset.errors)}"}
    end
  end

  def update(conn, %{"active" => device_active} = params) do
  %Device{} = device = conn.private[:device]
  device_name_arg = Map.get(params, "name", nil)

  device_update_attrs = %{
    name: device_name_arg,
    active: device_active
  }
  |> Enum.reject(fn {_key, value} -> is_nil(value) end)
  |> Enum.into(%{})

  with {:device_update_check, {:ok, %Device{} = updated_device}} <- {:device_update_check, Automation.update_device(device, device_update_attrs)}do
    conn
    |> render("show.json", device: updated_device)
  else
    {:device_update_check, {:error, %Ecto.Changeset{} = changeset}} -> {:error, :bad_request, "Error while updating the device: #{inspect(changeset.errors)}"}
  end
  end
end
