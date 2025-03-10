defmodule DaProductAppWeb.Router do
  use DaProductAppWeb, :router

  import DaProductAppWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DaProductAppWeb.Layouts, :root}
    plug :protect_from_forgery
    #plug :put_secure_browser_headers, %{"content-security-policy" => "default-src 'self'; img-src * data:;"}
    #add library which we want to add and make the list of it so that security check can be managed
     plug :put_secure_browser_headers, %{
    "content-security-policy" => 
      "default-src 'self'; " <>
      "script-src 'self' 'unsafe-inline' https://testapp.ariticapp.com; " <>
      "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com  ag-grid-community.min.js ag-grid-enterprise.js ag-charts-community.js ag-charts-enterprise.js; " <>
      "img-src * data:; " <>
      "font-src 'self' https://fonts.gstatic.com data:; " <>
      "connect-src 'self' wss://ariticapp.com;"
  }
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :non_csrf do
    plug :accepts, ["html","json"]
    plug :fetch_session
    plug :put_secure_browser_headers
    # Do NOT include :protect_from_forgery, so CSRF is not enforced here
  end

   scope "/", DaProductAppWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/form", FormLive, :index
    live "/live", PageLive, :index
    live "/live/modal/:size", PageLive, :modal
    live "/live/slide_over/:origin", SbomComponentLive, :slide_over
    live "/live/pagination/:page", PageLive, :pagination
  end


  scope "/", DaProductAppWeb do
    pipe_through :browser

    get "/", PageController, :home
    #resources "/software", SoftwareController, only: [:index, :show]
  end

  scope "/", DaProductAppWeb do
  pipe_through [:browser, :require_authenticated_user]
  live_session :default, on_mount: [{DaProductAppWeb.UserAuth, :mount_current_user}] do 
  live "/dashboard", DashboardLive, :index
  live "/sbomcomponent", SbomComponentLive, :index
  live "/sbomcomponent/:origin", SbomComponentLive, :slide_over
  live "/workflow", WorkflowLive
  live "/software", SoftwareLive
  live "/software/:id", SoftwareLive.Show
  end
  #live "/software/:id", SoftwareLive.Show, as: :software_show

  
  #resources "/software", SoftwareController, only: [:index, :show]
  #resources "/sbom_component", ComponentController, only: [:index]
  end





  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:da_product_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DaProductAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", DaProductAppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{DaProductAppWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
      live "/transactions/:id", TransactionLive.Show, :show
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", DaProductAppWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{DaProductAppWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", DaProductAppWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{DaProductAppWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end


  scope "/", DaProductAppWeb do
    pipe_through :non_csrf

    post "/transaction_post", TransactionPostController, :new
    end

   #scope "/", DaProductAppWeb do
   # pipe_through :browser
#
    # LiveView route showing the transaction details.
    #live "/transactions/:id", TransactionLive.Show, :show
  #end
  
end
