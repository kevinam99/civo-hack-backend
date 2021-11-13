defmodule ApiWeb.RoomView do
  use ApiWeb, :view

  alias ApiWeb.DeviceView
  alias ApiWeb.RoomView

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      room_id: room.id,
      room_name: room.name,
      devices: render_devices(room.devices)
    }
  end

  defp render_devices(%Ecto.Association.NotLoaded{}) do
    []
  end

  defp render_devices(devices) do
    render_many(devices, DeviceView, "device.json")
  end
end
