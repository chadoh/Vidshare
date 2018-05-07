defmodule Vidshare.Video do
  use Vidshare.Web, :model

  schema "videos" do
    field :video_link, :string
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:video_link, :name])
    |> validate_required([:video_link, :name])
  end
end
