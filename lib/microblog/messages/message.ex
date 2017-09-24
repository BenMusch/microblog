defmodule Microblog.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Messages.Message


  schema "messages" do
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
