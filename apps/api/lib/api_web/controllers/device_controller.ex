defmodule ApiWeb.DeviceController do
  use ApiWeb, :controller

  alias Api.Automations
  alias Dbstore.Device

  plug :put_view, ApiWeb.DeviceView

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    devices = Automations.list_devices()

    conn
    |> render("index.json", devices: devices)
  end

  def show(conn, _params) do
    %Device{} = device = conn.private[:device]

    db_device = Automations.get_device_with_preload(device.id)
    render(conn, "show.json", device: db_device)
  end

  @spec create(any, map) :: {:error, :bad_request, <<_::64, _::_*8>>} | Plug.Conn.t()
  def create(
        conn,
        %{
          "name" => _device_name
        } = params
      ) do
    device_attrs = get_device_attrs(params)
    room = Map.get(device_attrs, :room)

    with {:create_device_check, {:ok, %Device{} = device}} <-
           {:create_device_check, Automations.create_device(device_attrs, room)} do
      conn
      |> put_status(:created)
      |> render("show.json", device: device)
    else
      {:create_device_check, {:error, %Ecto.Changeset{} = changeset}} ->
        {:error, :bad_request, "Error while creating the device: #{inspect(changeset.errors)}"}
    end
  end

  def update(conn, %{"active" => device_active} = params) do
    %Device{} = device = conn.private[:device]
    device_update_attrs =
      get_device_attrs(params)
      # %{
      #   name: device_name_arg
      # }
      # |> Enum.reject(fn {_key, value} -> is_nil(value) end)
      # |> Enum.into(%{})
      |> Map.put(:active, device_active)

      room = Map.get(device_update_attrs, :room)

    with {:device_update_check, {:ok, %Device{} = updated_device}} <-
           {:device_update_check, Automations.update_device(device, room, device_update_attrs)} do
      conn
      |> render("show.json", device: updated_device)
    else
      {:device_update_check, {:error, %Ecto.Changeset{} = changeset}} ->
        {:error, :bad_request, "Error while updating the device: #{inspect(changeset.errors)}"}
    end
  end

  defp get_device_attrs(params) do
    device_name = Map.get(params, "name", nil)
    room_id_arg = Map.get(params, "room_id", nil)
    active_arg = Map.get(params, "active", nil)
    # room = if not is_nil(room_id_arg), do: Api.Rooms.get_room!(room_id_arg), else: nil

    room =
      case room_id_arg do
        nil ->
          nil

        _id ->
          case Api.Rooms.get_room(room_id_arg) do
            nil -> nil
            room -> room
          end
      end

    _device_attrs =
      %{
        name: device_name,
        room: room,
        active: active_arg
      }
      |> Enum.reject(fn {_key, value} -> is_nil(value) end)
      |> Enum.into(%{})
  end
end
