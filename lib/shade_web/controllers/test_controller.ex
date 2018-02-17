defmodule Shade.TestController do
  # Using
  use ShadeWeb.Web, :controller

  # Aliases
  alias Shade.Jokes.Joke
  alias Shade.Questions.Question

  def joke(conn, _param) do
    joke = Joke.get_joke()
    question = Question.get_question()

    conn
    |> assign(:joke, joke)
    |> assign(:question, question)
    |> render("test.html")
  end
end