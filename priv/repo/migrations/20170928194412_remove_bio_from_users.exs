defmodule Microblog.Repo.Migrations.RemoveBioFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :bio
    end
  end
end
