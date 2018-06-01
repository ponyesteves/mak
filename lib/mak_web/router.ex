defmodule MakWeb.Router do
  use MakWeb, :router
  import MakWeb.Auth, only: [check_admin: 2]

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

  pipeline :backoffice do
    plug(:check_admin)
  end

  pipeline :landing do
    plug(:put_layout, {MakWeb.LayoutView, "landing.html"})
  end


  # Public
  scope "/", MakWeb do
    pipe_through([:browser, :landing])

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
    resources("/orders", OrderController, only: [:create, :edit, :update, :show])
  end

  # BackOffice
  scope "/bo", MakWeb do
    pipe_through([:browser, :auth, :backoffice])
    get("/", BackofficeController, :index)

    resources("/users", UserController)
    resources("/orders", OrderController, only: [:index, :delete])
    get("/finish_order/:id", OrderController, :change_status)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MakWeb do
  #   pipe_through :api
  # end
end
