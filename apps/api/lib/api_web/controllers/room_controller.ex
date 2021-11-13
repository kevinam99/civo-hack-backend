defmodule ApiWeb.RoomController do
  use ApiWeb, :controller

  alias Api.Rooms
  alias Dbstore.Room

  action_fallback ApiWeb.FallbackController

  plug :put_view, ApiWeb.RoomView

  def index(conn, _params) do
    rooms = Rooms.list_rooms()

    render(conn, "index.json", rooms: rooms)
  end

  def show(conn, _params) do
    room_id = conn.path_params["room_id"]

    with {:get_room, %Room{} = room} when not is_nil(room) <-
           {:get_room, Rooms.get_room_with_preload(room_id)} do
      conn
      |> render("show.json", room: room)
    else
      {:get_room, nil} -> {:error, :not_found}
    end
  end
end
