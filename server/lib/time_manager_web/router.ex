defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug TimeManagerWeb.AuthenticationPlug
  end

  scope "/", TimeManagerWeb do
    pipe_through [:api]

    resources "/register", RegistrationController, only: [:show, :create, :new]
    resources "/signin", SessionController, only: [:show, :create]
  end

  scope "/", TimeManagerWeb do
    pipe_through [:api, :auth]

    resources "/users", UserController

    resources "/workingtimes", WorkingtimeController
    get "/workingtimes/:user", WorkingtimeController, :new
    get "/workingtimes/:user/:id", WorkingtimeController, :show, singleton: true
    
    get "/clocks/userID", ClockController, :show
    post "/clocks/:user", ClockController, :create

    resources "/teamusers", TeamUserController
    get "/teamusers/:team", TeamUserController, :show
    get "/teamusers/:user", TeamUserController, :show

    resources "/teams", TeamController

    resources "/widgets", WidgetController
    # get "/widgets/:id", WidgetController, :show

    resources "/widgetusers", WidgetUserController, except: [:show]
    get "/widgetusers/:widget", WidgetUserController, :show
    get "/userwidgets/:user", UserWidgetController, :show

  end
end
