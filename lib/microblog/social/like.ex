defmodule Microblog.Social.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.Like
  alias Microblog.Social.Message
  alias Microblog.Social.User


  schema "likes" do
    belongs_to :user, User
    belongs_to :message, Message

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:user_id, :message_id])
    |> validate_required([:user_id, :message_id])
  end
end
