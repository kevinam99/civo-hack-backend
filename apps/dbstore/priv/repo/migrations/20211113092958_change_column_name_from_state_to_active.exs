defmodule Dbstore.Repo.Migrations.ChangeColumnNameFromStateToActive do
  use Ecto.Migration

  def change do
    execute "alter table devices rename column state TO active"
  end
end
