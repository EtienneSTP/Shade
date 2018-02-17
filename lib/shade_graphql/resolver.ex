defmodule ShadeGraphql.Resolver do
  # Imports
  import Ecto.Query

  # Aliases
  alias Shade.Repo

  def one(queryable), do: {:ok, Repo.one(queryable)}

  def all(queryable), do: {:ok, Repo.all(queryable)}
end