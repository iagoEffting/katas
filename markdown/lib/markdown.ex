defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @regex_open_bold ~r/^#{"__"}{1}/
  @regex_close_bold ~r/#{"__"}{1}$/

  @regex_open_italic ~r/^[#{"_"}{1}][^#{"_"}+]/
  @regex_close_italic ~r/[^#{"_"}{1}]/
  @regex_short_italic ~r/_/

  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&process(&1))
    |> Enum.join()
    |> patch
  end

  defp process(token) do
    if String.starts_with?(token, "#") || String.starts_with?(token, "*") do
      if String.starts_with?(token, "#") do
        token
        |> String.split()
        |> parse_header_md_level
        |> enclose_with_header_tag
      else
        parse_list_md_level(token)
      end
    else
      token
      |> String.split()
      |> enclose_with_paragraph_tag
    end
  end

  defp parse_header_md_level([head | tail]) do
    {
      to_string(String.length(head)),
      Enum.join(tail, " ")
    }
  end

  defp parse_list_md_level(list) do
    tags =
      list
      |> String.trim_leading("* ")
      |> String.split()

    "<li>" <> join_words_with_tags(tags) <> "</li>"
  end

  defp enclose_with_header_tag({level, text}) do
    "<h" <> level <> ">" <> text <> "</h" <> level <> ">"
  end

  defp enclose_with_paragraph_tag(paragraph) do
    "<p>#{join_words_with_tags(paragraph)}</p>"
  end

  defp join_words_with_tags(tags) do
    tags
    |> Enum.map(&replace_md_with_tag(&1))
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(markdown) do
    markdown
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(markdown) do
    cond do
      markdown =~ @regex_open_bold ->
        String.replace(markdown, @regex_open_bold, "<strong>", global: false)

      markdown =~ @regex_open_italic ->
        String.replace(markdown, @regex_short_italic, "<em>", global: false)

      true ->
        markdown
    end
  end

  defp replace_suffix_md(markdown) do
    cond do
      markdown =~ @regex_close_bold -> String.replace(markdown, @regex_close_bold, "</strong>")
      markdown =~ @regex_close_italic -> String.replace(markdown, @regex_short_italic, "</em>")
      true -> markdown
    end
  end

  defp patch(list) do
    list
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
