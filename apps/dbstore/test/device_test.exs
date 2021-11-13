defmodule Dbstore.DeviceTest do
  use ExUnit.Case
  alias Dbstore.Device
  alias Dbstore.Repo
  alias Dbstore.TestHelper

  test "cannot create device without device name and id" do
    changeset = Device.changeset(%Device{}, %{name: ""})

    assert changeset.errors == [
             id: {"can't be blank", [validation: :required]},
             name: {"can't be blank", [validation: :required]}
           ]
  end

  test "cannot create device with invalid active status" do
    changeset =
      Device.changeset(%Device{}, %{name: "name", id: Ecto.UUID.generate(), active: :yes})

    assert changeset.errors == [
             active: {"is invalid", [type: :boolean, validation: :cast]}
           ]
  end

  test "can create device with valid attrs" do
    changeset =
      Device.changeset(%Device{}, %{name: "name", id: Ecto.UUID.generate(), active: true})

    assert changeset.errors == []

    device = Repo.insert!(changeset)
    assert device.name == "name"
    assert device.active == true
  end

  test "cannot update device with invalid attrs" do
    device = TestHelper.get_device() |> Repo.insert!()

    changeset = Device.update_changeset(device, %{name: nil, active: nil})

    assert changeset.errors == [
             name: {"can't be blank", [validation: :required]},
             active: {"can't be blank", [validation: :required]}
           ]
  end

  test "can update device with valid attrs" do
    device = TestHelper.get_device() |> Repo.insert!()

    changeset = Device.update_changeset(device, %{name: "new", active: false})

    assert changeset.errors == []

    updated_device = Repo.update!(changeset)
    assert updated_device.name == "new"
    assert updated_device.active == false
    assert updated_device.id == device.id
  end
end
