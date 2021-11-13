defmodule Dbstore.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :name, :string
      add :state, :boolean, default: false, null: false

      timestamps()
    end
  end
end
