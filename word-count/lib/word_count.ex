defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> sanitize_sentence
    |> split_sentence
    |> get_occurrences()
  end

  defp get_occurrences(phrase_list) do
    Enum.reduce(phrase_list, %{}, &has_word(&1, &2))
  end

  defp has_word(value, accumulate) do
    if Map.has_key?(accumulate, value) do
      Map.put(accumulate, value, accumulate[value] + 1)
    else
      Map.put(accumulate, value, 1)
    end
  end

  defp sanitize_sentence(sentence) do
    sentence = Regex.replace(~r/:|!|\&|\$|\^|@|%|,/, sentence, "")
    sentence = Regex.replace(~r/  |_/, sentence, " ")

    String.downcase(sentence)
  end

  defp split_sentence(sentence), do: String.split(sentence, " ")
end
