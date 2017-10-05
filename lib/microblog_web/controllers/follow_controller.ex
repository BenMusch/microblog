defmodule MicroblogWeb.FollowController do
  use MicroblogWeb, :controller

  alias Microblog.Social
  alias Microblog.Social.Follow

  def create(conn, %{"follow" => follow_params}) do
    case Social.create_follow(follow_params) do
      {:ok, _follow} ->
        IO.puts(follow_params["following_id"])
        following = Social.get_user!(follow_params["following_id"])
        conn
        |> redirect(to: user_path(conn, :show, following))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"follow" => follow_params}) do
    follow = Social.get_follow(follower_id: follow_params["follower_id"],
                               following_id: follow_params["following_id"])
    Social.delete_follow(follow)

    conn
      |> put_flash(:info, "Follow deleted successfully.")
      |> redirect(to: message_path(conn, :index))
  end
end
