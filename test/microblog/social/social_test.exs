defmodule Microblog.SocialTest do
  use Microblog.DataCase

  alias Microblog.Social

  describe "messages" do
    alias Microblog.Social.Message

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Social.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Social.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Social.create_message(@valid_attrs)
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Social.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.content == "some updated content"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_message(message, @invalid_attrs)
      assert message == Social.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Social.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Social.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Social.change_message(message)
    end
  end

  describe "users" do
    alias Microblog.Social.User

    @valid_attrs %{email: "some email", handle: "some handle", human_name: "some human_name"}
    @update_attrs %{email: "some updated email", handle: "some updated handle", human_name: "some updated human_name"}
    @invalid_attrs %{email: nil, handle: nil, human_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Social.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Social.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Social.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.handle == "some handle"
      assert user.human_name == "some human_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Social.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.handle == "some updated handle"
      assert user.human_name == "some updated human_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_user(user, @invalid_attrs)
      assert user == Social.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Social.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Social.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Social.change_user(user)
    end
  end
end
