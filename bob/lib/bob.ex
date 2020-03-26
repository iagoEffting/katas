defmodule Bob do
  def hey(input) do
    cond do
      input == "" ->
        "Fine. Be that way!"

      input =~ ~r([A-Z ]{4,}+[?]+) ->
        "Calm down, I know what I'm doing!"

      input =~ ~r(^[A-Z]]*$|^[А-Я]*$) && String.upcase(input) == input ->
        "Whoa, chill out!"

      input =~ ~r(^[ a-zA-Z0-9]+[?]+[ ]*$) || String.ends_with?(input, "?") ->
        "Sure."

      input =~ ~r([A-Z]{2,}) && String.upcase(input) == input ->
        "Whoa, chill out!"

      input =~ ~r(^[\s]*$) ->
        "Fine. Be that way!"

      true ->
        "Whatever."
    end
  end
end
