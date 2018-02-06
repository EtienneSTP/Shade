defmodule Shade.Repo.Migrations.CreateEvent do
  # Using
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, size: 255, null: false
      add :type, :string, size: 255, null: false
      add :description, :string, size: 2047, null: false
      add :bonus, {:array, :string}, size: 2047
      add :weigth, :integer, null: false
    end
  end
end
