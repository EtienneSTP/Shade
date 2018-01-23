defmodule Shade.Repo.Migrations.CreateEvent do
  # Using
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string

      timestamps()
    end
  end
end
