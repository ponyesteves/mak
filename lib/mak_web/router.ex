defmodule MakWeb.Router do
  use MakWeb, :router

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
    plug(MakWeb.Guardian.AuthAccessPipeline)
  end

  pipeline :landing do
    plug(:put_layout, {MakWeb.LayoutView, "landing.html"})
  end

  # Public
  scope "/", MakWeb do
    pipe_through([:browser, :landing])

    resources("/users", UserController, only: [:new, :create, :edit, :update])
    resources("/sessions", SessionController, only: [:new, :create])

    get("/", SessionController, :new)
    delete("/sessions/drop", SessionController, :drop)
  end

  # Private
  scope "/", MakWeb do
    pipe_through([:browser, :auth])

    resources("/machines", MachineController) do
      resources("/orders", OrderController, only: [:new, :create])
    end
    resources("/users", UserController, only: [:index, :show, :delete])
    resources("/types", TypeController)
    resources("/orders", OrderController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MakWeb do
  #   pipe_through :api
  # end
end
