defmodule Shade.Jokes.Joke do
  def get_joke() do
    url = "https://icanhazdadjoke.com"
    header = ["Accept": "text/plain"]

    elem(HTTPoison.get(url, header), 1).body
  end
end