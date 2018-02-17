defmodule ShadeGraphql.Events.Resolver do
  # Imports
  import Ecto.Query

  # Aliases
  alias Shade.Events.Event
  alias Shade.Events.Service
  alias ShadeGraphql.Resolver

  def random_event(_, _) do
    {:ok, Service.play_random()}
  end
end