defmodule Vidshare.Review do
  use Vidshare.Web, :model

  schema "reviews" do
    field(:video_review_link, :string)
    field(:comment, :string)
    belongs_to(:user, Vidshare.User)
    belongs_to(:video, Vidshare.Video)

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:video_review_link, :comment, :user_id, :video_id])
    |> validate_required([:video_id, :user_id])
  end
end
