defmodule Dbstore.TestHelper do
  ExUnit.start()

  alias Dbstore.Device

  def get_device() do
    device = %{name: "device", active: false, id: Ecto.UUID.generate()}
    Device.changeset(%Device{}, device)
  end
end
