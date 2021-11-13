defmodule Api.AutomationsTest do
  use ExUnit.Case

  alias Api.Automations

  describe "devices" do
    alias Dbstore.Device

    @valid_attrs %{name: "some name", active: true}
    @update_attrs %{name: "updated", active: false}
    @invalid_attrs %{name: nil, active: nil}

    def device_fixture(attrs \\ %{}) do
      {:ok, device} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Automations.create_device()

      device
    end

    test "list_devices/0 returns all devices" do
      _device = device_fixture()
      assert Automations.list_devices() > 0
    end

    test "get_device/1 returns the device with given id" do
      device = device_fixture()
      assert Automations.get_device(device.id) == device
    end

    test "create_device/1 with valid data creates a device" do
      assert {:ok, %Device{} = device} = Automations.create_device(@valid_attrs)
      assert device.name == @valid_attrs.name
      assert device.active == true
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Automations.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()
      assert {:ok, %Device{} = device} = Automations.update_device(device, @update_attrs)
      assert device.name == @update_attrs.name
      assert device.active == false
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Automations.update_device(device, @invalid_attrs)
      assert device == Automations.get_device(device.id)
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = Automations.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> Automations.get_device!(device.id) end
    end

    test "change_device/1 returns a device changeset" do
      device = device_fixture()
      assert %Ecto.Changeset{} = Automations.change_device(device)
    end
  end
end
