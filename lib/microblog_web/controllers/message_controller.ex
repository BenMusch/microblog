defmodule MicroblogWeb.MessageController do
  use MicroblogWeb, :controller

  alias Microblog.Social
  alias Microblog.Social.Message
  alias Microblog.Repo

  def index(conn, _params) do
    changeset = Social.change_message(%Message{})

    if user_id = get_session(conn, :user_id) do
      user = Social.get_user!(user_id)
      user = Repo.preload(user, [:following_follows, :followings, :following_messages])
      messages = Repo.preload(user.following_messages, :user)
    else
      messages = Social.list_messages()
    end

    render(conn, "index.html", messages: messages, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Social.change_message(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    case Social.create_message(message_params) do
      {:ok, message} ->
        message = Repo.preload(message, :user)
        json = MicroblogWeb.MessageView.message_json(conn, message)
        MicroblogWeb.Endpoint.broadcast!("updates:all", "message", json)

        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Social.get_message!(id)
    render(conn, "show.html", message: message)
  end

  def delete(conn, %{"id" => id}) do
    message = Social.get_message!(id)
    {:ok, _message} = Social.delete_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: message_path(conn, :index))
  end
end
