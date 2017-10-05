defmodule MicroblogWeb.LikeController do
  use MicroblogWeb, :controller

  alias Microblog.Social
  alias Microblog.Social.Like

  action_fallback MicroblogWeb.FallbackController

  def create(conn, %{"like" => like_params}) do
    case Social.like(like_params["user_id"], like_params["message_id"]) do
      {:ok, _like} ->
        send_resp(conn, :created, "")
    end
  end

  def delete(conn, %{"like" => like_params}) do
    case Social.unlike(like_params["user_id"], like_params["message_id"]) do
      {:ok, _like} ->
        send_resp(conn, :no_content, "")
    end
  end
end
