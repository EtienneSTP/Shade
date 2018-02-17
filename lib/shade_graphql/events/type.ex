defmodule ShadeGraphql.Events.Type do
  # Usings
  use Absinthe.Schema.Notation

  # Aliases
  alias ShadeGraphql.Events.Resolver

  object :event_queries do
    field :random_event, :event do
      resolve(&Resolver.random_event/2)
    end
  end

  object :event do
    field :name, :string
    field :type, :string
    field :description, :string
    field :bonus, list_of(:string)
  end
end