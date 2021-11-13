defmodule Dbstore.Device do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :name, :string
    field :state, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :state])
    |> validate_required([:name, :state])
  end
end
