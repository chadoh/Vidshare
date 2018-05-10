defmodule Vidshare.ReviewController do
  use Vidshare.Web, :controller
  plug(:authenticate_user)
  plug(:authenticate_admin when action in [:new, :create, :delete])

  alias Vidshare.Review
  alias Vidshare.User
  alias Vidshare.Video
  alias Vidshare.Auth

  def index(conn, _params) do
    user = Auth.session(conn)
    reviews = Repo.all(Review)
    render(conn, "index.html", reviews: reviews, user: user)
  end

  def new(conn, _params) do
    videos = Repo.all(Video)
    users = Repo.all(User)
    changeset = Review.changeset(%Review{})
    render(conn, "new.html", changeset: changeset, users: users, videos: videos)
  end

  def create(conn, %{"review" => review_params}) do
    users = Repo.all(User)
    changeset = Review.changeset(%Review{}, review_params)

    case Repo.insert(changeset) do
      {:ok, _review} ->
        conn
        |> put_flash(:info, "Review created successfully.")
        |> redirect(to: review_path(conn, :index))

      {:error, changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.session(conn)
    review = Repo.get!(Review, id)
    render(conn, "show.html", review: review, user: user)
  end

  def edit(conn, %{"id" => id}) do
    videos = Repo.all(Video)
    users = Repo.all(User)
    review = Repo.get!(Review, id)
    changeset = Review.changeset(review)
    render(conn, "edit.html", review: review, changeset: changeset, videos: videos, users: users)
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = Repo.get!(Review, id)
    changeset = Review.changeset(review, review_params)
    IO.inspect(review_params)
    IO.inspect(changeset)

    case Repo.update(changeset) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review updated successfully.")
        |> redirect(to: review_path(conn, :show, review))

      {:error, changeset} ->
        render(conn, "edit.html", review: review, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = Repo.get!(Review, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(review)

    conn
    |> put_flash(:info, "Review deleted successfully.")
    |> redirect(to: review_path(conn, :index))
  end
end
