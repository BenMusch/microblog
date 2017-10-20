defmodule MicroblogWeb.MessageView do
  use MicroblogWeb, :view

  def message_json(conn, message, current_user \\ nil) do
    url = message_path(conn, :delete, message)
    user_url = user_path(conn, :show, message.user.id)
    %{
      "user" => %{
        "id" => message.user.id,
        "path" => user_url,
        "handle" => message.user.handle,
        "name" => message.user.human_name
      },
      "id" => message.id,
      "userId" => message.user_id,
      "createdAt" => "#{message.inserted_at}",
      "likedByCurrentUser" => current_user && Microblog.Social.user_likes?(current_user, message),
      "numLikes" => Microblog.Social.num_likes(message),
      "avatarUrl" => Gravity.image(message.user.email),
      "content" => message.content,
      "path" => url
    }
  end

  def encode_messages(conn, messages, current_user \\ nil) do
    messages = Enum.map(messages, fn m -> message_json(conn, m, current_user) end)
    encoded = Poison.encode!(messages)
    encoded
  end
end
