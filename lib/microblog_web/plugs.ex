defmodule MicroblogWeb.Plugs do
  import Plug.Conn

  def set_user(conn, _opts) do
    if user_id = get_session(conn, :user_id) do
      user = Microblog.Social.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end
