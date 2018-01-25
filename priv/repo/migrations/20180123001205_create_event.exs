defmodule Shade.Repo.Migrations.CreateEvent do
  # Using
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :type, :string
      add :description, :string
      add :bonus, :string
      add :weigth, :integer

      timestamps()
    end
  end
end
