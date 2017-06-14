defmodule PostRegister.Web.EmailsController do
  use PostRegister.Web, :controller
  alias PostRegister.Blogs
  require Logger

  def callback(conn, %{"envelope" => %{"to" => to, "from" => from}, "headers" => %{"Subject" => subject}, "html" => html_body}) do
    with {:ok, log} <- find_log(to),
         :ok <- check_allowed_to_post(log, from),
         {:ok, post} <- create_post(log, %{from: from, subject: subject, html: html_body}) do
      Logger.debug("created post: #{inspect(post)}")
      conn |> text("it worked")
    else
      result ->
        Logger.error("didn't work! #{inspect(result)}")
        conn |> text("it didn't work")
    end
  end

  defp find_log(email_address) do
    case Blogs.find_log(email_address: email_address) do
      nil -> {:error, :not_found}
      log -> {:ok, log}
    end
  end

  defp check_allowed_to_post(log, from_email_address) do
    case log.from_email_addresses do
      [] -> :ok
      addresses ->
        Logger.debug("from email addresses: #{inspect(addresses)}")
        if addresses |> Enum.member?(from_email_address) do
          :ok
        else
          {:error, :not_found}
        end
    end
  end

  defp create_post(log, attrs) do
    Blogs.create_post(log, attrs)
  end
end
