defmodule PostRegister.Blogs.Log do
  use Ecto.Schema
  @timestamps_opts [type: :utc_datetime, usec: true]
  import Ecto.Changeset
  alias PostRegister.Blogs.{Log, Post}

  schema "logs" do
    has_many :posts, Post

    field :name, :string
    field :email_address, :string

    timestamps()
  end

  def changeset(%Log{} = log, attrs) do
    log
    |> cast(attrs, [:name, :email_address])
    |> validate_required([:name, :email_address])
  end
end
