defmodule PostRegister.Repo.Migrations.CreatePostRegister.Blogs.Log do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :name, :string, null: false
      add :email_address, :string, null: false

      timestamps()
    end
    index :logs, [:email_address]
  end
end
