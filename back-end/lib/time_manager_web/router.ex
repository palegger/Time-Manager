defmodule TodolistWeb.Router do
  use TodolistWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: "*"
  end
  pipeline :auth do
    plug TodolistWeb.Auth
  end

  scope "/api", TodolistWeb do
    pipe_through :api

    # USERS
    post "/users/sign_in", UserController, :signin
    post "/users/sign_up", UserController, :create
    pipe_through :auth
    get "/users/:id", UserController, :show
    get "/users/",UserController, :index
    delete "/users/:id",UserController, :delete
    put "/users/:id",UserController, :update
    put "/users/promote/:id", UserController, :promote
    # post "/users/sign_out", UserController, :signout

    post "workingtimes/user/:userID", WorkingtimeController, :indexperiod
    get "workingtimes/:id", WorkingtimeController, :show
    post "workingtimes/:userID", WorkingtimeController, :create
    put "workingtimes/:id", WorkingtimeController, :update
    delete "workingtimes/:id", WorkingtimeController, :delete

    get "clocks/user/:userID", ClockController, :indexclocks
    post "clocks/:userID", ClockController, :create
    get "clocks/:id", ClockController, :show
    # TEAMS
    post "/teams/:name", TeamController, :create
    delete "/teams/:id", TeamController, :delete
    put "/teams/:id", TeamController, :update
    get "/teams/:id", TeamController, :show

    #TEAMUSER
    post "/teams/add/:teamid/:userid",TeamuserController, :create
    # get "/teams/users/:id", TeamuserController, :show
    get "/teams/users/:teamid", TeamuserController, :indexTeam

    get "/teams/users/", TeamuserController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: TodolistWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
