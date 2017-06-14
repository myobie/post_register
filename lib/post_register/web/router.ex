defmodule PostRegister.Web.Router do
  use PostRegister.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PostRegister.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/emails", PostRegister.Web do
    post "/callback", EmailsController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", PostRegister.Web do
  #   pipe_through :api
  # end
end
