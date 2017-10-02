defmodule MicroblogWeb.Router do
  use MicroblogWeb, :router
  import MicroblogWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :set_user
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
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end
end
