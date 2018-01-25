defmodule Shade.Events.Service do
  #Alias
  alias Shade.Events.Event
  alias Shade.Players.Player

  #Constants
  @card_number    ~w(1 2 3 4 5 6 7 8 9 10 Jack Queen King)s
  @card_types     ~w(Heart Diamond Spade Club)s
  @dice_low       ~w(1d2 1d4 1d6)s
  @dice_mid       ~w(1d2 1d4 1d6 1d8 1d10)s
  @dice_high      ~w(1d2 1d4 1d6 1d8 1d10 1d12 1d20)s

  @player_amount  ["Everyone", "{%PI} vs {%PI}", "{%PI} and {%PI} vs {%PI} and {%PI}",]
  @target_type    ["anyone", "anyone", "anyone", "the opponent", "{%PT}", "{%PT} and {%PT}", "{%PT} or {%PT}"]
  @element_type %{
    player_initial:           "{%PI}",
    player_target:            "{%PT}",

    amount_player_initial:    "AI",
    amount_player_target:     "AT",

    dice_low:                 "DL",
    dice_mid:                 "DM",
    dice_high:                "DH",

    card_number:              "CN",
    card_type:                "CT"
  }

  def play_random do
    selected_event =
      Event.Queries.all_id_weigth()
      |> create_weigthed_list()
      |> Enum.random()
      |> Event.Queries.by_id()

    description =
      selected_event.description
      |> update_event_description()

    player = Player.Queries.random(count_element(description, @element_type.player_initial))
    target = Player.Queries.random(count_element(description, @element_type.player_target))

    updated_description =
      description
      |> insert_player(player, @element_type.player_initial)
      |> insert_player(target, @element_type.player_target)

    %{name: selected_event.name, type: selected_event.type, description: updated_description}
  end

  def play_crit_famble(type) do
    event = Event.Queries.random_by_type(type)

    description =
      event.description
      |> insert_player([%{name: "You"}], @element_type.player_initial)
      |> update_event_description()

    %{name: event.name, type: event.type, description: description}
  end

  defp create_weigthed_list(list) do
    Enum.reduce(list, [], fn(event, acc) -> append_weigthed_list(event.id, event.weigth, acc) end)
  end

  defp append_weigthed_list(_, weigth, result) when weigth == 0, do: result
  defp append_weigthed_list(id, weigth, result) do
    append_weigthed_list(id, weigth - 1, result ++ [id])
  end

  #TODO: validate amount of event having more then one instance of same element(worth generating each time?)
  defp update_event_description(description) do
    element = %{
      @element_type.dice_low => Enum.random(@dice_low),
      @element_type.dice_mid => Enum.random(@dice_mid),
      @element_type.dice_high => Enum.random(@dice_high),

      @element_type.card_number => Enum.random(@card_number),
      @element_type.card_type => Enum.random(@card_types),

      @element_type.amount_player_initial => Enum.random(@player_amount),
      @element_type.amount_player_target => Enum.random(@target_type)
    }

    Regex.replace(~r/{([a-zA-Z]+)?}/, description, fn(_, match) -> element[match] end)
  end

  defp count_element(description, element) do
    description
    |> String.split()
    |> Enum.count(fn x -> x == element end)
  end

  defp insert_player(desc, [], _), do: desc
  defp insert_player(desc, [head | tail], type) do
    insert_player(String.replace(desc, type, head.name, global: false), tail, type)
  end

  #Test

  def test_random() do
    test_random(1000, [])
  end
  def test_random(count, result) when count == 0, do: Enum.reduce(result, %{}, fn(element, acc) -> Map.update(acc, element, 1, &(&1 + 1)) end)
  def test_random(count, result) do
    events_list = Event.Queries.all_id_weigth()
    events_weigthed_list = create_weigthed_list(events_list)
    selected_event = Event.Queries.by_id(Enum.random(events_weigthed_list))
    test_random(count - 1, result ++ [selected_event.name])
  end
end

#TODO: create lib/shade/helper directory for function like process_weigthed_list, count element
#TODO: Test process in the right directory [how to run test]
#TODO: Create a constant file