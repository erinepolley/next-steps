defmodule NextSteps.Repo do
  use AshPostgres.Repo, otp_app: :next_steps

  # This is required for migrations.
  # https://hexdocs.pm/ash_postgres/AshPostgres.Repo.html#module-installed-extensions
  def installed_extensions do
    ~w[ash-functions citext]
  end
end
