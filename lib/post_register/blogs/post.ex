defmodule PostRegister.Blogs.Post do
  use Ecto.Schema
  @timestamps_opts [type: :utc_datetime, usec: true]
  import Ecto.Changeset
  alias PostRegister.Blogs.{Log, Post, HtmlSanitizer}

  schema "posts" do
    belongs_to :log, Log

    field :from, :string
    field :html, :string
    field :subject, :string

    timestamps()
  end

  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:subject, :from, :html])
    |> sanitize_html()
    |> validate_required([:subject, :from, :html])
    |> foreign_key_constraint(:log_id)
  end

  def sanitize_html(%Ecto.Changeset{} = changeset) do
    case get_change(changeset, :html) do
      nil -> changeset
      html -> put_change(changeset, :html, HtmlSanitizer.sanitize(html))
    end
  end
end
