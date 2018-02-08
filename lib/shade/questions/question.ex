defmodule Shade.Questions.Question do

  # Constants
  @url          "https://opentdb.com/api.php?amount=1"
  @easy         "&difficulty=easy"
  @medium       "&difficulty=medium"
  @hard         "&difficulty=hard"


  def get_question() do
    response =
      @url
      |> HTTPoison.get()
      |> elem(1)

    body =
      response.body
      |> Poison.decode()
      |> elem(1)

    body
    |> Map.get("results")
    |> List.first()
  end

  def get_question(:easy) do
    #joke = elem(HTTPoison.get(url, header), 1).body
  end
end