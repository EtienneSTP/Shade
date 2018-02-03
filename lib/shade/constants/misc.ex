defmodule Shade.Constants.Misc do
  # Constants
  @high_low       ~w(highest lowest)s

  def get_misc(type) do
    case type do
      :high_low ->
        Enum.random(@high_low)
    end
  end
end