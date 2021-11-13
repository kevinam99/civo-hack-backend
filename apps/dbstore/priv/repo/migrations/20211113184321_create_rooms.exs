defmodule Dbstore.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :id, :string, primary_key: true, null: false, default: Ecto.UUID.generate()
      add :name, :string

      timestamps()
    end
      create unique_index(:rooms, [:id, :name])
      create index(:rooms, :id)
  end
end
