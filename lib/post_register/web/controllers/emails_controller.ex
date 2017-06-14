defmodule PostRegister.Web.EmailsController do
  use PostRegister.Web, :controller

  def callback(conn, %{"envelope" => %{"to" => to, "from" => from}, "headers" => %{"Subject" => subject}, "html" => html_body}) do
    IO.inspect({:to, to})
    IO.inspect({:from, from})
    IO.inspect({:subject, subject})
    IO.inspect({:body, html_body})
    conn |> text("worked")
  end
end
