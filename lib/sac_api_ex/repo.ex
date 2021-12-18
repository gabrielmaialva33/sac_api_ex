defmodule SacApiEx.Repo do
  use Ecto.Repo,
    otp_app: :sac_api_ex,
    adapter: Ecto.Adapters.Postgres
end
