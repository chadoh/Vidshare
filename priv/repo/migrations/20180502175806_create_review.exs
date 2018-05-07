defmodule Vidshare.Repo.Migrations.CreateReview do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add(:video_review_link, :string)
      add(:comment, :string)
      add(:user_id, references(:users, on_delete: :nothing))
      add(:video_id, references(:videos, on_delete: :nothing))

      timestamps()
    end

    create(index(:reviews, [:user_id]))
    create(index(:reviews, [:video_id]))
  end
end
