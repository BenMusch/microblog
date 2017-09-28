defmodule Microblog.Social.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.User
  alias Microblog.Social.Message


  schema "users" do
    field :email, :string
    field :handle, :string
    field :human_name, :string
    has_many :messages, Microblog.Social.Message

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:human_name, :handle,:email])
    |> validate_required([:human_name, :handle, :email])
  end
end
