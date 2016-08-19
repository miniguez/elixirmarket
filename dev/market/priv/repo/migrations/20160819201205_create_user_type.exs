defmodule Market.Repo.Migrations.CreateUserType do
  use Ecto.Migration

  def change do
    create table(:user_types) do
      add :type, :string, size: 10, null: false

      timestamps
    end

  end
end
