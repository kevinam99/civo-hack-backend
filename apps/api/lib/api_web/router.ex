defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :device_auth do
    plug ApiWeb.Plugs.DeviceAuth
  end

  scope "/api", ApiWeb do
    pipe_through :api

    resources "/", PageController, only: [:index]
    resources "/devices", DeviceController, only: [:index, :create]
    resources "/rooms", RoomController, only: [:index, :show]
  end

  scope "/api", ApiWeb do
    pipe_through [:api, :device_auth]

    resources "/devices", DeviceController, only: [:show, :update], param: "device_id"
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
      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end
end
