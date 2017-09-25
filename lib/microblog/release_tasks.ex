defmodule Microblog.ReleaseTasks do

  @start_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto
  ]

  @myapps [
    :microblog
  ]

  @repos [
    Microblog.Repo
  ]

  def migrate do
    IO.puts "Loading microblog application..."
    :ok = Application.load(:microblog)

    IO.puts "Starting dependencies..."
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    IO.puts "Starting repos..."
    Enum.each(@repos, &(&1.start_link(pool_size: 1)))

    IO.puts "Running micrgrations..."
    Enum.each(@myapps, &run_migrations_for/1)

    IO.puts "Success!"
    :init.stop()
  end

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

  defp run_migrations_for(app) do
    IO.puts "Running migrations for #{app}"
    Ecto.Migrator.run(Microblog.Repo, migrations_path(app), :up, all: true)
  end

  defp migrations_path(app), do: Path.join([priv_dir(app), "repo", "migrations"])
end
