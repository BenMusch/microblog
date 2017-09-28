defmodule Microblog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :human_name, :string
      add :handle, :string
      add :bio, :text
      add :email, :string

      timestamps()
    end

  end
end
