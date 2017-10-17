defmodule Microblog.Social.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.User
  alias Microblog.Social.Message
  alias Microblog.Social.Follow

  schema "users" do
    field :email, :string
    field :handle, :string
    field :human_name, :string

    has_many :messages, Message, on_delete: :delete_all
    # The follows where the follower is this user
    # In other words, this user is following the user associated through this
    # follow
    has_many :following_follows, Follow, foreign_key: :follower_id, on_delete: :delete_all
    # The follows where the following is this user
    # In other words, this user is followed by the user associated through this
    # follow
    has_many :follower_follows, Follow, foreign_key: :following_id, on_delete: :delete_all

    # Ths users that follow this user
    has_many :followers, through: [:follower_follows, :follower]
    # Ths users this user is following
    has_many :followings, through: [:following_follows, :following]

    has_many :following_messages, through: [:followings, :messages]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:human_name, :handle,:email])
    |> validate_required([:human_name, :handle, :email])
  end
end
