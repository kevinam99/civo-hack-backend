defmodule Dbstore.DeviceTest do
  use ExUnit.Case
  alias Dbstore.Device
  alias Dbstore.Repo
  test "cannot create device without device name and id" do
    changeset = Device.changeset(%Device{}, %{name: ""})

    assert changeset.errors == [
      id: {"can't be blank", [validation: :required]},
  name: {"can't be blank", [validation: :required]}
    ]
  end

  test "cannot create device with invalid active status" do
    changeset = Device.changeset(%Device{}, %{name: "name", id: Ecto.UUID.generate(), active: :yes})

    assert changeset.errors == [
      active: {"is invalid", [type: :boolean, validation: :cast]}
    ]
  end

  test "can create device with valid attrs" do
    changeset = Device.changeset(%Device{}, %{name: "name", id: Ecto.UUID.generate(), active: true})
    assert changeset.errors == []

    device = Repo.insert!(changeset)
    assert device.name == "name"
    assert device.active == true
  end
end
