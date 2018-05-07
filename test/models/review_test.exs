defmodule Vidshare.ReviewTest do
  use Vidshare.ModelCase

  alias Vidshare.Review

  @valid_attrs %{comment: "some content", video_review_link: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Review.changeset(%Review{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Review.changeset(%Review{}, @invalid_attrs)
    refute changeset.valid?
  end
end
