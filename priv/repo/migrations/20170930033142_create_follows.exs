defmodule Microblog.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :following_id, references(:users, on_delete: :nothing)
      add :follower_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:follows, [:following_id])
    create index(:follows, [:follower_id])
  end
end
