defmodule Dbstore.Device do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  schema "devices" do
    field :name, :string
    field :active, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Dbstore.Device{} = device, attrs) do
    device
    |> cast(attrs, [:id, :name, :active])
    |> validate_length(:name, min: 3, max: 10)
    |> validate_required([:id, :name])
  end

  def update_changeset(%Dbstore.Device{} = device, attrs) do
    device
    |> cast(attrs, [:name, :active])
    |> validate_length(:name, min: 3, max: 10)
    |> validate_required([:name, :active])
  end
end
