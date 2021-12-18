defmodule SacApiExWeb.Router do
  use SacApiExWeb, :router

  alias SacApiExWeb.{WebsiteController, TroubleController}

  pipeline :api do
    plug :accepts, ["json"]

    resources "/websites", WebsiteController, only: [:index, :show, :create, :update, :delete]
    resources "/troubles", TroubleController, only: [:index, :show, :create, :update, :delete]
  end

  scope "/api", SacApiExWeb do
    pipe_through :api
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
      live_dashboard "/dashboard", metrics: SacApiExWeb.Telemetry
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
