defmodule MicroblogWeb.UserController do
  use MicroblogWeb, :controller
  require Logger

  alias Microblog.Social
  alias Microblog.Social.User
  alias Microblog.Repo

  def index(conn, params) do
    if params["q"] do
      users = Social.search_users(params["q"])
    else
      users = Social.list_users()
    end
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Social.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Social.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Social.get_user!(id)
    messages = Repo.preload(user, :messages).messages
    messages = Repo.preload(messages, :user)
    render(conn, "show.html", user: user, messages: messages)
  end

  def edit(conn, %{"id" => id}) do
    user = Social.get_user!(id)
    changeset = Social.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Social.get_user!(id)

    case Social.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Social.get_user!(id)
    {:ok, _user} = Social.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
