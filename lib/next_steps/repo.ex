defmodule NextSteps.Repo do
  use Ecto.Repo,
    otp_app: :next_steps,
    adapter: Ecto.Adapters.Postgres
end
