defmodule PostRegister.Repo.Migrations.CreatePostRegister.Blogs.Post do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :log_id, references(:logs, on_delete: :delete_all)
      add :subject, :string, null: false
      add :from, :string, null: false
      add :html, :string, null: false

      timestamps()
    end

  end
end
