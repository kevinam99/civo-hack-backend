defmodule ApiWeb.DeviceView do
  use ApiWeb, :view

  alias ApiWeb.DeviceView

  def render("index.json", devices: devices) do
  %{data: %{devices: render_many(devices, DeviceView, "device.json")}}
  end

  def render("show.json", device: device) do
    %{data: %{device: render_one(device, DeviceView, "device.json")}}
    end

  def render("device.json", device: device) do
  %{
      device_id: device.id,
      device_name: device.name,
      device_state: device.state
  }
  end
end
