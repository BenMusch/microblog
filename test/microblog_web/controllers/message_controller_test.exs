defmodule MicroblogWeb.MessageControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.Messages

  @create_attrs %{content: "some content"}
  @invalid_attrs %{content: nil}

  def fixture(:message) do
    {:ok, message} = Messages.create_message(@create_attrs)
    message
  end

  describe "index" do
    test "lists all messages", %{conn: conn} do
      conn = get conn, message_path(conn, :index)
      assert html_response(conn, 200)
    end
  end

  describe "new message" do
    test "renders form", %{conn: conn} do
      conn = get conn, message_path(conn, :new)
      assert html_response(conn, 200) =~ "Create a New Message"
    end
  end

  describe "create message" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, message_path(conn, :create), message: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == message_path(conn, :show, id)

      conn = get conn, message_path(conn, :show, id)
      assert html_response(conn, 200) =~ @create_attrs.content
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, message_path(conn, :create), message: @invalid_attrs
      assert html_response(conn, 200) =~ "Create a New Message"
    end
  end

  describe "delete message" do
    setup [:create_message]

    test "deletes chosen message", %{conn: conn, message: message} do
      conn = delete conn, message_path(conn, :delete, message)
      assert redirected_to(conn) == message_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, message_path(conn, :show, message)
      end
    end
  end

  defp create_message(_) do
    message = fixture(:message)
    {:ok, message: message}
  end
end
