defmodule ApiWeb.DeviceControllerTest do
  use ApiWeb.ConnCase
  alias Api.Automations

  @valid_attrs %{name: "some name", active: true}
  @update_attrs %{name: "updated", active: false}
  @invalid_attrs %{name: nil, active: nil}

  def fixture(:device, attrs \\ @valid_attrs) do
    {:ok, device} = Automations.create_device(attrs)
    device
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "shows all existing devices in system", %{conn: conn} do
      conn =
        conn
        |> get(Routes.device_path(conn, :index))

      assert json_response(conn, 200)["data"] |> Enum.count() > 0
    end
  end

  describe "show" do
    test "renders success and shows the device", %{conn: conn} do
      device = fixture(:device)

      conn =
        conn
        |> get(Routes.device_path(conn, :show, device.id))

      assert %{
               "device_active" => active,
               "device_id" => device_id,
               "device_name" => device_name
             } = json_response(conn, 200)["data"]

      assert active == device.active
      assert device_id == device.id
      assert device_name == device.name
    end

    test "renders not found when sending unknown device_id", %{conn: conn} do
      conn =
        conn
        |> get(Routes.device_path(conn, :show, "unknown id"))

      assert response(conn, 401) == "{\"error\":\"Device not found\"}"
    end
  end

  describe "create" do
    test "creates the device", %{conn: conn} do
      conn =
        conn
        |> post(Routes.device_path(conn, :create, @valid_attrs))

      assert %{
               "device_active" => false,
               "device_id" => device_id,
               "device_name" => device_name
             } =
               json_response(conn, 201)["data"]

      assert device_name == @valid_attrs.name
    end

    test "renders error when creating with invalid attrs", %{conn: conn} do
      conn =
        conn
        |> post(Routes.device_path(conn, :create, @invalid_attrs))

        assert %{
          "detail" => "Error while creating the device: [name: {\"can't be blank\", [validation: :required]}]"
        } = json_response(conn, 400)["errors"]
    end
  end

  describe "update" do
    test "renders success and shows the updated device", %{conn: conn} do
    device = fixture(:device)
      conn =
      conn
      |> patch(Routes.device_path(conn, :update, device.id), @update_attrs)

      assert %{
        "device_active" => active,
        "device_id" => device_id,
        "device_name" => device_name
      } = json_response(conn, 200)["data"]

      assert active == @update_attrs.active
      assert device_id == device.id
      assert device_name == @update_attrs.name
    end

    test "renders error with invalid update attrs", %{conn: conn} do
      device = fixture(:device)
      conn =
        conn
        |> patch(Routes.device_path(conn, :update, device.id), @invalid_attrs)

        assert %{
          "detail" => "Error while updating the device: [active: {\"can't be blank\", [validation: :required]}]"
        }
       = json_response(conn, 400)["errors"]
    end
  end
end