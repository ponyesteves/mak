defmodule CeiboBaseWeb.Router do
  use CeiboBaseWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(CeiboBaseWeb.Guardian.AuthAccessPipeline)
  end


  scope "/", CeiboBaseWeb do
    # Use the default browser stack
    pipe_through(:browser)
    get("/", PageController, :index)
    resources("/users", UserController, only: [:new, :create, :edit, :update])
    resources("/sessions", SessionController, only: [:new, :create])
    delete("/sessions/drop", SessionController, :drop)
  end

  scope "/", CeiboBaseWeb do
    # Use the default browser stack
    pipe_through([:browser, :auth])
    resources("/users", UserController, only: [:index, :show, :delete])
  end

  # Other scopes may use custom stacks.
  # scope "/api", CeiboBaseWeb do
  #   pipe_through :api
  # end
end
