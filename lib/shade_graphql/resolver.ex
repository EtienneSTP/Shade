defmodule ShadeGraphql.Resolver do
  # Imports
  import Ecto.Query

  # Aliases
  alias Shade.Repo

  def one(query), do: {:ok, query}

  def all(query), do: {:ok, query}
end