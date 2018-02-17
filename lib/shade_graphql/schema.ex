defmodule ShadeGraphql.Schema do
  # Using
  use Absinthe.Schema

  # Alias
  alias Shade.Resolvers

  # Types
  #import_types Absinthe.Type.Custom
  import_types ShadeGraphql.Events.Type

  query do
    import_fields(:event_queries)
    #field :user, :user do
    #  arg :id, non_null(:id)
     # resolve &Resolvers.Accounts.find_user/3
    #end
  end

end