defmodule NextSteps.Repo do
  use AshPostgres.Repo, otp_app: :next_steps

  # This is required for migrations.
  # https://hexdocs.pm/ash_postgres/AshPostgres.Repo.html#module-installed-extensions
  def installed_extensions do
    ~w[ash-functions citext]
  end

  # Gives a warning if not present in this module.
  # https://hexdocs.pm/ash_postgres/AshPostgres.Repo.html#c:min_pg_version/0
  def min_pg_version do
    %Version{major: 16, minor: 0, patch: 0}
  end
end
