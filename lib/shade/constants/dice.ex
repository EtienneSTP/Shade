defmodule Shade.Constants.Dice do
  # Constants
  @dice_low       ~w(1d2 1d4 1d6)s
  @dice_mid       ~w(1d2 1d4 1d6 1d8 1d10)s
  @dice_high      ~w(1d2 1d4 1d6 1d8 1d10 1d12 1d20)s

  def get_dice(type) do
    case type do
      :low ->
        Enum.random(@dice_low)
      :mid ->
        Enum.random(@dice_mid)
      :high ->
        Enum.random(@dice_high)
    end
  end
end