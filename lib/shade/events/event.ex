defmodule Shade.Events.Event do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Shade.Events.Event

  schema "events" do
    field :description, :string
    field :name, :string
    field :player, :integer
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:name, :type, :description, :player])
    |> validate_required([:name, :type, :description, :player])
  end

  defmodule Queries do
    def random do
      query_random_event = Shade.Repo.one(from event in Event,
                                           select: %{ name: event.name, type: event.type, description: event.description, player: event.player },
                                           order_by: [asc: fragment("RANDOM()")],
                                           limit: 1)
    end
    def random_by_type(type) do
      query_event_by_type = Shade.Repo.one(from event in Event,
                                            where: event.type == ^type,
                                            select: %{ name: event.name, type: event.type, description: event.description, player: event.player},
                                            order_by: [asc: fragment("RANDOM()")],
                                            limit: 1)
    end
  end
end


