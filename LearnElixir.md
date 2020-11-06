# ** ELIXIR BACKEND **

## CMD IMPORTANTE
* mix phx.new PATH [--module or MODULE] [--app APP] #Create new Phoenix Project with flags 'https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html'
--no-html # No HTML views
--no-webpack # No Webpack files for static asset building
- Ex : mix phx.new time_manager --app time_manager_app --module TimeManager --no-html --no-webpack

* mix phx.server #Launch server with flags 'https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Server.html'

* mix phx.routes "nameRoute" #show all route or specific route 'https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Routes.html'

* mix phx.gen.schema #Generated Ecto Schema & Migration
- Ex: mix phx.gen.schema Blog.Post(Schema Module) blog_posts(table) title:string views:integer (data)

* mix phx.gen.context #Generated a context with functions around an Ecto schema
- Ex : mix phx.gen.context Accounts(Context Module) User(Schema) users name:string age:integer(data)

* mix phx.gen.json #Generates controllers, views and context for JSON resource
- Ex : mix phx.gen.json Accounts(Context Module) User(Schema) users name:string age:integer(data)

## DOC IMPORTANTE
* Define a Phoenix Router : https://hexdocs.pm/phoenix/Phoenix.Router.html
* Request of all application : https://hexdocs.pm/phoenix/Phoenix.Endpoint.html
* Phoenix controllers : https://hexdocs.pm/phoenix/Phoenix.Controller.html
* Define the View Layer of Phoenix : https://hexdocs.pm/phoenix/Phoenix.View.html
* Template : https://hexdocs.pm/phoenix/Phoenix.Template.html

### Route Elixir : https://devhints.io/phoenix-routing

Show all route : mix phx.routers

  scope "/", BootstrapWeb do
    pipe_through :browser

    get "/users", UserController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BootstrapWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit, :index]

    scope "/tasks" do # api/tasks/*
     resources "/", TaskController, except: [:new, :edit, :update] #do
    #   resources("/users", UserController, only: [:show])
    #  end
      put("/:id", TaskController, :update)  # api/tasks/:id
      get("/users/:idUser", TaskUserController, :index) # /api/tasks/users/:idUser
    end
    #  get("/tasks", UserController, :index)
    #  get("/tasks/:id", UserController, :show)
    #  post("/tasks/", UserController, :create)
    #  get("/tasks/users/:idUser", UserController, :show)
  end
end

# Ecto

## Mix Task
- mix ecto #Print Ecto tasks available
- mix ecto.create #Create the storage for the given repository :https://hexdocs.pm/ecto/Mix.Tasks.Ecto.Create.html
Ex : mix ecto.create -r Custom.Repo
- mix ecto.drop #Drop the storage for the repo : https://hexdocs.pm/ecto/Mix.Tasks.Ecto.Drop.html
Ex : mix ecto.drop -r Custom.Repo
- mix ecto.gen.repo #Generate the new repo(placed in the lib) : https://hexdocs.pm/ecto/Mix.Tasks.Ecto.Gen.Repo.html
Ex : mix ecto.gen.repo -r Custom.Repo