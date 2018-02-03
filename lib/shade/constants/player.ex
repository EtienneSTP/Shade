defmodule Shade.Constants.Player do
  # Constants
  @initial_low  ["Everyone", "{%PI} vs {%PI}"]
  @target_low    ["anyone", "anyone", "anyone", "the opponent", "{%PT}", "{%PT} and {%PT}", "{%PT} or {%PT}"]
  @initial_high  ["Everyone", "{%PI} vs {%PI}", "{%PI} and {%PI} vs {%PI} and {%PI}"]
  @target_high    ["anyone", "anyone", "anyone", "the opponent", "{%PT}", "{%PT} and {%PT}", "{%PT} or {%PT}"]

  def get_player(:low, type) do
    case type do
      :initial ->
        Enum.random(@initial_low)
      :target ->
        Enum.random(@target_low)
    end
  end

  def get_player(:high, type) do
    case type do
      :initial ->
        Enum.random(@initial_high)
      :target ->
        Enum.random(@target_high)
    end
  end
end