defmodule ShadeGraphql.Events.Type do
  # Usings
  use Absinthe.Schema.Notation

  # Aliases
  alias ShadeGraphql.Events.Resolver

  object :event_queries do
    field :event, :event do
      resolve(&Resolver.one/0)
    end
  end

  object :event do
    field :name, :string
    field :type, :string
    field :description, :string
    field :bonus, list_of(:string)
    field :weigth, :integer
  end
end