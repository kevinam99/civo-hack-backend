defmodule Dbstore.Device do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  schema "devices" do
    field :name, :string
    field :active, :boolean, default: false

    belongs_to :room, Dbstore.Room, type: :string
    timestamps()
  end

  @doc false
  def changeset(%Dbstore.Device{} = device, attrs) do
    device
    |> cast(attrs, [:id, :name, :active])
    |> validate_length(:name, min: 3, max: 12)
    |> validate_required([:id, :name])
  end

  def changeset(%Dbstore.Device{} = device, %Dbstore.Room{} = room, attrs) do
    device
    |> cast(attrs, [:id, :name, :active])
    |> validate_length(:name, min: 3, max: 12)
    |> validate_required([:id, :name])
    |> put_assoc(:room, room)
    |> foreign_key_constraint(:room_id)
  end

  def update_changeset(%Dbstore.Device{} = device, attrs) do
    device
    |> cast(attrs, [:name, :active])
    |> validate_length(:name, min: 3, max: 12)
    |> validate_required([:name, :active])
  end

  def update_changeset(%Dbstore.Device{} = device, %Dbstore.Room{} = room, attrs) do
    device
    |> cast(attrs, [:name, :active])
    |> validate_length(:name, min: 3, max: 12)
    |> validate_required([:name, :active])
    |> put_assoc(:room, room)
    |> foreign_key_constraint(:room_id)
  end
end
