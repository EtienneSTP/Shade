defmodule Shade.Helpers.General do
  def create_weigthed_list(list) do
    Enum.reduce(list, [], fn(event, acc) -> append_weigthed_list(event.id, event.weigth, acc) end)
  end

  def count_element(string, element) do
    string
    |> String.split()
    |> Enum.count(fn x -> x == element end)
  end

  def chance_select(probability) do
    result=
    1..probability
      |> Enum.random()

    result == probability
  end

  defp append_weigthed_list(_, weigth, result) when weigth == 0, do: result
  defp append_weigthed_list(id, weigth, result) do
    append_weigthed_list(id, weigth - 1, result ++ [id])
  end
end