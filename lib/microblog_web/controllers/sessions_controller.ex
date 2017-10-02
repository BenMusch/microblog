# Credit: https://github.com/NatTuck/nu_mart/commit/f36cb662af356da2957622a1181eff882fbccf84
defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias Microblog.Social

  def create(conn, %{"username" => username}) do
    user = Social.get_user_by_username(username)

    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.handle}")
      |> redirect(to: message_path(conn, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "No user found")
      |> redirect(to: message_path(conn, :index))
    end
  end

  def delete(conn, _args) do
    conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: message_path(conn, :index))
  end
end
