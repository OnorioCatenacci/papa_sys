defmodule PapaSysWeb.Router do
  use PapaSysWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PapaSysWeb do
    pipe_through :api
    resources "/users", UserController
    resources "/visits", VisitController
    resources "/transactions", TransactionController
  end
end
