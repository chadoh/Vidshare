defmodule Vidshare.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string)
      add(:name, :string)
      add(:password, :string)
      add(:password_hash, :string)
      add(:permission, :integer, default: 0)

      timestamps()
    end
  end
end
