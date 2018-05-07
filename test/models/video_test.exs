defmodule Vidshare.VideoTest do
  use Vidshare.ModelCase

  alias Vidshare.Video

  @valid_attrs %{name: "some content", video_link: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Video.changeset(%Video{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Video.changeset(%Video{}, @invalid_attrs)
    refute changeset.valid?
  end
end
