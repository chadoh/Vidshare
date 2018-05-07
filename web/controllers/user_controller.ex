defmodule Vidshare.UserController do
  use Vidshare.Web, :controller
  plug(:authenticate_user when action in [:index, :show, :delete, :update, :edit, :profile])
  plug(:authenticate_admin when action in [:index, :show, :delete])

  alias Vidshare.User
  alias Vidshare.Auth
  alias Vidshare.Review

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    users = Repo.get(User, id)
    render(conn, "show.html", user: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Vidshare.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :profile))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  def profile(conn, _params) do
    review = Repo.all(Review)
    user = Auth.session(conn)

    render(conn, "profile.html", user: user, review: review)
  end
end
