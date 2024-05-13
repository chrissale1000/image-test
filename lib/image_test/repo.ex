defmodule ImageTest.Repo do
  use Ecto.Repo,
    otp_app: :image_test,
    adapter: Ecto.Adapters.Postgres
end
