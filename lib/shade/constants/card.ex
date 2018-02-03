defmodule Shade.Constants.Card do
  # Constants
  @card_number    ~w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)s
  @card_type     ~w(Heart Diamond Spade Club)s

  def get_card(type) do
    case type do
      :number ->
        Enum.random(@card_number)
      :type ->
        Enum.random(@card_type)
    end
  end
end