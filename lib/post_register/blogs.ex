defmodule PostRegister.Blogs do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias PostRegister.Repo
  alias PostRegister.Blogs.{Log, Post}

  def find_log([id: id]) do
    Log |> Repo.get(id)
  end

  def find_log([email_address: email_address]) do
    Log |> Repo.get_by(email_address: email_address)
  end

  def create_log(attrs \\ %{}) do
    %Log{}
    |> Log.changeset(attrs)
    |> Repo.insert()
  end

  def list_posts(%Log{} = log) do
    Repo.all(from p in Post, where: p.log_id == ^log.id)
  end

  def get_post!(%Log{} = log, id) do
    Repo.one!(from p in Post, where: (p.id == ^id and p.log_id == ^log.id))
  end

  def create_post(%Log{} = log, attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> put_assoc(:log, log)
    |> Repo.insert()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end
end
