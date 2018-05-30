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

    delete("/sessions/drop", SessionController, :drop)
  end
  #

  # Private
  scope "/", MakWeb do
    pipe_through([:browser, :auth])
    get("/", GateController, :index)
    get("/import", ImportController, :machines)

    resources("/m", MachineController) do
      resources("/orders", OrderController, only: [:new])
    end
    resources("/codes", CodeController)
    resources("/orders", OrderController)
  end

  # BackOffice
  scope "/backoffice", MakWeb do
    pipe_through([:browser, :auth])
    get("/", BackofficeController, :index)

    resources("/users", UserController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MakWeb do
  #   pipe_through :api
  # end
end
