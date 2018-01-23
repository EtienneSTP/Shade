defmodule Shade.Players.Player do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Shade.Players.Player


  schema "players" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Player{} = player, attrs) do
    player
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  defmodule Queries do
    def random(amount) do
      query_random_player = Shade.Repo.all(from player in Player,
                                            select: %{name: player.name},
                                            order_by: [asc: fragment("RANDOM()")],
                                            limit: ^amount)
    end
  end
end