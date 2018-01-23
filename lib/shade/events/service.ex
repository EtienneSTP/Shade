defmodule Shade.Events.Service do
  #Alias
  alias Shade.Events.Event
  alias Shade.Players.Player

  #Constants
  @card_types   ~w(Heart Diamond Spade Club)s
  @dice_low     ~w(1d2 1d4 1d6)s
  @dice_mid     ~w(1d2 1d4 1d6 1d8 1d10)s
  @dice_high    ~w(1d2 1d4 1d6 1d8 1d10 1d12 1d20)s

  def random_event do
    event = Event.Queries.random()
    player = Player.Queries.random(event.player)

    description = event.description
                  |> insert_player(player)
                  |> insert_card()
                  |> insert_dice

    %{name: event.name, type: event.type, description: description}
  end

  def critic do
    event = Event.Queries.random_by_type("critic")

    description = event.description
                  |> insert_player([%{name: "You"}])
                  |> insert_card()
                  |> insert_dice

    %{name: event.name, type: event.type, description: description}
  end

  def famble do
    event = Event.Queries.random_by_type("famble")

    description = event.description
                  |> insert_player([%{name: "You"}])
                  |> insert_card()
                  |> insert_dice

    %{name: event.name, type: event.type, description: description}
  end

  defp insert_player(desc, []), do: desc
  defp insert_player(desc, [head | tail]) do
    insert_player(String.replace(desc, "{%P}", head.name, global: false), tail)
  end

  defp insert_card(desc) do
    cond do
      String.contains?(desc, "{%C}") ->
        insert_card(String.replace(desc, "{%C}", Enum.random(@card_types), global: false))
      true ->
        desc
    end
  end

  defp insert_dice(desc) do
    cond do
      String.contains?(desc, "{%Dl}") ->
        insert_dice(String.replace(desc, "{%Dl}", Enum.random(@dice_low), global: false))
      String.contains?(desc, "{%Dm}") ->
        insert_dice(String.replace(desc, "{%Dm}", Enum.random(@dice_mid), global: false))
      String.contains?(desc, "{%Dh}") ->
        insert_dice(String.replace(desc, "{%Dh}", Enum.random(@dice_high), global: false))
      true ->
        desc
    end
  end
end