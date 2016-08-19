defmodule Market.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, size: 120
      add :username, :string, null: false, size: 15
      add :password_hash, :string

      timestamps
    end
    create unique_index(:users, [:username])
  end
end
