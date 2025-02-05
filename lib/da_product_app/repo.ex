defmodule DaProductApp.Repo do
  use Ecto.Repo,
    otp_app: :da_product_app,
    adapter: Ecto.Adapters.MyXQL
end
