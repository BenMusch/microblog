defmodule Microblog.Social do
  @moduledoc """
  The Social context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.Social.Message

  def list_messages do
    Repo.preload(Repo.all(Message), :user)
  end

  def messages_by_followings(user) do
    user = Repo.preload(user, [:following_follows, :followings])
    Repo.preload(Repo.all(Message, user: user.followings), :user)
  end

  def get_message!(id), do: Repo.preload(Repo.get!(Message, id), :user)

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  def change_message(%Message{} = message) do
    Message.changeset(message, %{})
  end

  alias Microblog.Social.User

  def list_users do
    Repo.all(User)
  end

  def search_users(q) do
    q = String.trim(q)
    if q != "" do
      q = "%#{q}%"
      Repo.all(from u in User, where: ilike(u.handle, ^q) or ilike(u.human_name, ^q))
    else
      []
    end
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_username(username), do: Repo.get_by(User, handle: username)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Microblog.Social.Follow

  def create_follow(attrs \\ %{}) do
    %Follow{}
    |> Follow.changeset(attrs)
    |> Repo.insert()
  end

  def get_follow(follow_params \\ %{}) do
    Repo.get_by(Follow, follow_params)
  end

  def delete_follow(%Follow{} = follow) do
    Repo.delete(follow)
  end

  def user_is_following?(user1, user2) do
    !!Repo.get_by(Follow, following_id: user2.id, follower_id: user1.id)
  end

  alias Microblog.Social.Like

  def create_like(attrs \\ %{}) do
    %Like{}
    |> Like.changeset(attrs)
    |> Repo.insert()
  end

  def like(user_id, message_id) do
    create_like(%{"user_id" => user_id, "message_id" =>  message_id})
  end

  def unlike(user_id, message_id) do
    like = Repo.get_by(Like, user_id: user_id, message_id: message_id)
    Repo.delete(like)
  end

  def user_likes?(user, message) do
    user && !!Repo.get_by(Like, user_id: user.id, message_id: message.id)
  end

  def num_likes(message) do
    query = from(l in Like, where: l.message_id == ^message.id)
    Repo.aggregate(query, :count, :id)
  end
end
