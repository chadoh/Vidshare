defmodule Vidshare.Router do
  use Vidshare.Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Vidshare.Auth, repo: Vidshare.Repo)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", Vidshare do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/profile", UserController, :profile)
    resources("/users", UserController)
    resources("/videos", VideoController)
    resources("/sessions", SessionController, only: [:new, :create, :delete])
    resources("/reviews", ReviewController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", Vidshare do
  #   pipe_through :api
  # end
end
