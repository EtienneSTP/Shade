defmodule Shade.Events.Event do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Shade.Events.Event

  schema "events" do
    field :name, :string
    field :type, :string
    field :description, :string
    field :bonus, {:array, :string}
    field :weigth, :integer

    timestamps()
  end

  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:name, :type, :description, :bonus, :weigth])
    |> validate_required([:name, :type, :description, :bonus, :weigth])
  end

  defmodule Queries do
    def by_id(id) do
      query_event_by_id = Shade.Repo.one(from event in Event,
                                           where: event.id == ^id,
                                           select: %{name: event.name, type: event.type, description: event.description, bonus: event.bonus})
    end
    def all_id_weigth() do
      query_event_weigth = Shade.Repo.all(from event in Event,
                                         select: %{id: event.id, weigth: event.weigth})
    end
    def random_by_type(type) do
      query_event_by_type = Shade.Repo.one(from event in Event,
                                            where: event.type == ^type,
                                            select: %{name: event.name, type: event.type, description: event.description, bonus: event.bonus},
                                            order_by: [asc: fragment("RANDOM()")],
                                            limit: 1)
    end
  end
end


