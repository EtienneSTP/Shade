defmodule ShadeWeb.Test do
  use ShadeWeb.Web, :model

  schema "tests" do
    field :name, :string
    field :type, :string
    field :player, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :type, :player])
    |> validate_required([:name, :type, :player])
  end
end
