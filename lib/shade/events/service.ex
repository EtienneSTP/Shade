defmodule Shade.Events.Service do
  # Alias
  alias Shade.Events.Event
  alias Shade.Players
  alias Shade.Constants.Dice
  alias Shade.Constants.Card
  alias Shade.Constants.Player
  alias Shade.Constants.Misc
  alias Shade.Helpers.General

  # Constants
  @element_type %{
    player_initial:           "{%PI}",
    player_target:            "{%PT}",

    amount_player_initial:    "AI",
    amount_player_target:     "AT",

    dice_low:                 "DL",
    dice_mid:                 "DM",
    dice_high:                "DH",

    card_number:              "CN",
    card_type:                "CT",

    high_low:                 "HL"
  }

  def play_random do
    selected_event =
      Event.Queries.all_id_weigth()
      |> General.create_weigthed_list()
      |> Enum.random()
      |> Event.Queries.by_id()

    description =
      selected_event.description
      |> update_event_description()

    player =
      description
      |> General.count_element(@element_type.player_initial)
      |> Players.Player.Queries.random()

    target =
      description
      |> General.count_element(@element_type.player_target)
      |> Players.Player.Queries.random()

    updated_description =
      description
      |> insert_player(player, @element_type.player_initial)
      |> insert_player(target, @element_type.player_target)

    %{name: selected_event.name, type: selected_event.type, description: updated_description, bonus: selected_event.bonus}
  end

  def play_crit_famble(type) do
    event = Event.Queries.random_by_type(type)

    description =
      event.description
      |> insert_player([%{name: "You"}], @element_type.player_initial)
      |> update_event_description()

    %{name: event.name, type: event.type, description: description, bonus: event.bonus}
  end

  defp update_event_description(description) do
    element = %{
      @element_type.dice_low              => Dice.get_dice(:low),
      @element_type.dice_mid              => Dice.get_dice(:mid),
      @element_type.dice_high             => Dice.get_dice(:high),

      @element_type.card_number           => Card.get_card(:number),
      @element_type.card_type             => Card.get_card(:type),

      @element_type.amount_player_initial => Player.get_player(:high, :initial),
      @element_type.amount_player_target  => Player.get_player(:high, :target),

      @element_type.high_low              => Misc.get_misc(:high_low)
    }

    Regex.replace(~r/{([a-zA-Z]+)?}/, description, fn(_, match) -> element[match] end)
  end

  defp insert_player(desc, [], _), do: desc
  defp insert_player(desc, [head | tail], type) do
    insert_player(String.replace(desc, type, head.name, global: false), tail, type)
  end

  #Test
  def test_random() do
    test_random(1000, [])
  end
  def test_random(count, result) when count == 0 do
    result
    |> Enum.reduce(%{}, fn(element, acc) -> Map.update(acc, element, 1, &(&1 + 1)) end)
    #|> Enum.sort()
  end
  def test_random(count, result) do
    events_list = Event.Queries.all_id_weigth()
    events_weigthed_list = General.create_weigthed_list(events_list)
    selected_event = Event.Queries.by_id(Enum.random(events_weigthed_list))
    test_random(count - 1, result ++ [selected_event.name])
  end
end

#TODO: create lib/shade/helper directory for function like process_weigthed_list, count element
#TODO: Test process in the right directory [how to run test]
#TODO: Create a constant file