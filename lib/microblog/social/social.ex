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
end
