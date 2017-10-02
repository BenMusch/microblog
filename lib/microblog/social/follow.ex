defmodule Microblog.Social.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.Follow
  alias Microblog.Social.User


  schema "follows" do
    belongs_to :following, User, foreign_key: :following_id
    belongs_to :follower, User, foreign_key: :follower_id

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:follower_id, :following_id])
    |> validate_required([:follower_id, :following_id])
  end
end
