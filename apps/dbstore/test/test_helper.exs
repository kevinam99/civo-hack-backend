defmodule TestHelper do
  ExUnit.start()

  alias Dbstore.Device

  def get_device() do
    device = %{name: "device", active: false}
    Device.changeset(%Device{}, device)
  end
end
