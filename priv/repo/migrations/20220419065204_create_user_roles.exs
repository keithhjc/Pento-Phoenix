defmodule Pento.Repo.Migrations.CreateUserRoles do
  use Ecto.Migration

  def change do
    create table(:user_roles) do
      add :user_id, :integer
      add :role_id, :integer

      timestamps()
    end
  end
end
