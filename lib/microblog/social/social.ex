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

  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
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
end
