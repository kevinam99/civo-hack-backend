defmodule ApiWeb.DeviceView do
  use ApiWeb, :view

  alias ApiWeb.DeviceView
  alias ApiWeb.RoomView

  def render("index.json", %{devices: devices}) do
    %{data: render_many(devices, DeviceView, "device.json")}
  end

  def render("show.json", %{device: device}) do
    %{data: render_one(device, DeviceView, "device.json")}
  end

  def render("device.json", %{device: device}) do
    %{
      device_id: device.id,
      device_name: device.name,
      device_active: device.active,
      room: render_room(device.room)
    }
  end

  def render_room(%Ecto.Association.NotLoaded{}) do
    []
  end
  def render_room(room) do
    render_one(room, RoomView, "room_basic.json")
  end
end
