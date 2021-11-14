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

  def changeset(room, %Dbstore.Device{} = device, attrs) do
    room
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
    |> put_assoc(:devices, device)
  end

  def update_changeset(%Dbstore.Room{} = room, attrs) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:id, :name])
  end

  def update_changeset(%Dbstore.Room{} = room, %Dbstore.Device{} = device, attrs) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:id, :name])
    |> put_assoc(:devices, device)
  end
end
