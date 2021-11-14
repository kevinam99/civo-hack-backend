defmodule Dbstore.Repo.Migrations.AddRoomToDevice do
  use Ecto.Migration

  def change do
    alter table(:devices) do
      add :room_id, references(:rooms, type: :string), default: nil, null: true
    end

    create index(:devices, [:room_id])
    create unique_index(:devices, [:id, :room_id])
  end
end
