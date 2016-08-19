defmodule Market.Repo.Migrations.AddForeingKeyUserUsertype do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :user_type_id, references(:user_types)
    end
  end
end
