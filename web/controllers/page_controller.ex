defmodule Vidshare.PageController do
  use Vidshare.Web, :controller

  alias Vidshare.Auth

  def index(conn, _params) do
    if Auth.session(conn) == nil do
      user = 'none'
    else
      user = Auth.session(conn)
    end

    render(conn, "index.html", user: user)
  end
end
