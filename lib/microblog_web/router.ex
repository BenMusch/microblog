defmodule MicroblogWeb.Router do
  use MicroblogWeb, :router
  use Coherence.Router
  import MicroblogWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :set_user
    plug Coherence.Authentication.Session
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MicroblogWeb do
    pipe_through :browser # Use the default browser stack

    get "/", MessageController, :index
    resources "/messages", MessageController, except: [:edit, :update]
    delete "/follows", FollowController, :delete # uses not-quite RESTful routes
                                                 # so you dont need the id of a
                                                 # follow to delete it
    resources "/follows", FollowController, only: [:create]
    resources "/users", UserController
    post "/login", Coherence.SessionController, :create
    delete "/logout", Coherence.SessionController, :delete
  end

  scope "/api", MicroblogWeb do
    pipe_through :api

    resources "/likes", LikeController, only: [:create]
    delete "/likes", LikeController, :delete # uses not-quite RESTful routes
                                              # so you dont need the id of a
                                              # follow to delete it
  end
end
