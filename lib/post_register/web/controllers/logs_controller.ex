defmodule PostRegister.Web.LogsController do
  use PostRegister.Web, :controller
  alias PostRegister.Blogs

  def show(conn, %{"id" => id}) do
    log = Blogs.find_log(id: id)
    posts = Blogs.list_posts(log)

    conn
    |> render("show.html", log: log, posts: posts)
  end
end
