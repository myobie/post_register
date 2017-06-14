defmodule PostRegister.Web.PageController do
  use PostRegister.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
