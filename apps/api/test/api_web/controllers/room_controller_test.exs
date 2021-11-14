defmodule ApiWeb.RoomControllerTest do
  use ApiWeb.ConnCase

  alias Api.Rooms

  @valid_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Rooms.create_room()

    room
  end

  @room Rooms.create_room(@valid_attrs)
        |> Tuple.to_list()
        |> Enum.at(1)

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "renders success and shows all rooms", %{conn: conn} do
      conn =
        conn
        |> get(Routes.room_path(conn, :index))

      assert json_response(conn, 200) |> Enum.count() > 0
    end
  end

  describe "show" do
    test "renders success and shows the room with devices", %{conn: conn} do
      conn =
        conn
        |> get(Routes.room_path(conn, :show, @room.id))

      assert %{
               "devices" => _devices,
               "room_id" => _id,
               "room_name" => _room_name
             } = json_response(conn, 200)["data"]
    end

    test "renders error when sending non exisiting room_id", %{conn: conn} do
      conn =
        conn
        |> get(Routes.room_path(conn, :show, "smth random"))

      assert json_response(conn, 404)["errors"]
    end
  end

  describe "create" do
    test "renders success and creates a room", %{conn: conn} do
      conn =
        conn
        |> post(Routes.room_path(conn, :create, @valid_attrs))

      assert %{
               "devices" => _devices,
               "room_id" => _room_id,
               "room_name" => room_name
             } = json_response(conn, 201)["data"]

      assert room_name == @valid_attrs.name
    end

    test "renders error when invalid attrs are sent", %{conn: conn} do
      conn =
        conn
        |> post(Routes.room_path(conn, :create, @invalid_attrs))

      assert %{
               "detail" =>
                 "Error occurred while creating the room: [name: {\"can't be blank\", [validation: :required]}]"
             } ==
               json_response(conn, 400)["errors"]
    end
  end
end
