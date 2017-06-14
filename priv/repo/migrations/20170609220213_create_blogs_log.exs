defmodule PostRegister.Repo.Migrations.CreatePostRegister.Blogs.Log do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :name, :string, null: false
      add :email_address, :string, null: false
      add :from_email_addresses, {:array, :string}

      timestamps()
    end
    index :logs, [:email_address]
  end
end
