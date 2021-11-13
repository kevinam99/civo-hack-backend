defmodule Dbstore.Repo.Migrations.ModifyDevicePrimaryKey do
  use Ecto.Migration

  def change do
    alter table(:devices) do
      modify(:id, :string)
    end
  end
end
