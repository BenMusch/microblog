defmodule MicroblogWeb.UserView do
  use MicroblogWeb, :view

  def users_equal?(user1, user2) do
    user1 && user2 && user1.id == user2.id
  end
end
