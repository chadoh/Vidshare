defmodule Vidshare.Repo.Migrations.CreateVideo do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add(:video_link, :string)
      add(:name, :string)

      timestamps()
    end
  end
end
