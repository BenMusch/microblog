defmodule Coherence.Redirects do
  @moduledoc """
  * session_create/2
  * session_delete/2
  * password_create/2
  * password_update/2,
  * unlock_create_not_locked/2
  * unlock_create_invalid/2
  * unlock_create/2
  * unlock_edit_not_locked/2
  * unlock_edit/2
  * unlock_edit_invalid/2
  * registration_create/2
  * invitation_create/2
  * confirmation_create/2
  * confirmation_edit_invalid/2
  * confirmation_edit_expired/2
  * confirmation_edit/2
  * confirmation_edit_error/2
  """
  use Redirects
  import MicroblogWeb.Router.Helpers


  def session_delete(conn, _), do: redirect(conn, to: message_path(conn, :index))
  def session_create(conn, _), do: redirect(conn, to: message_path(conn, :index))
  def session_create_invalid(conn, _), do: redirect(conn, to: message_path(conn, :index))
  def registration_create(conn, _), do: redirect(conn, to: message_path(conn, :index))
end
