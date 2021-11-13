defmodule Dbstore.Room do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  schema "rooms" do
    field :name, :string

    has_many(:devices, Dbstore.Device)
    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
  end
end
