defmodule PostRegister.Blogs do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias PostRegister.Repo
  alias PostRegister.Blogs.{Log, Post}

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%Log{}, ...]

  """
  def list_logs do
    Repo.all(Log)
  end

  @doc """
  Gets a single log.

  Raises `Ecto.NoResultsError` if the Log does not exist.

  ## Examples

      iex> get_log!(123)
      %Log{}

      iex> get_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log!(id) do
    Repo.get!(Log, id)
  end

  @doc """
  Creates a log.

  ## Examples

      iex> create_log(%{name: "Test Log"})
      {:ok, %Log{name: "Test Log"}}

      iex> create_log(%{})
      {:error, %Ecto.Changeset{}}

  """
  def create_log(attrs \\ %{}) do
    %Log{}
    |> Log.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a log.

  ## Examples

      iex> update_log(log, %{field: new_value})
      {:ok, %Log{}}

      iex> update_log(log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_log(%Log{} = log, attrs) do
    log
    |> Log.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Log.

  ## Examples

      iex> delete_log(log)
      {:ok, %Log{}}

      iex> delete_log(log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log(%Log{} = log) do
    Repo.delete(log)
  end

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts(log)
      [%Post{}, ...]

  """
  def list_posts(%Log{} = log) do
    Repo.all(from p in Post, where: p.log_id == ^log.id)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(log, 123)
      %Post{}

      iex> get_post!(log, 456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(%Log{} = log, id) do
    Repo.one!(from p in Post, where: (p.id == ^id and p.log_id == ^log.id))
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(%Log{} = log, attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> put_assoc(:log, log)
    |> Repo.insert()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end
end
