defmodule PapaSys.Repo do
  use Ecto.Repo,
    otp_app: :papa_sys,
    adapter: Ecto.Adapters.SQLite3
end
