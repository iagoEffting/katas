defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna('G'), do: 'C'
  def to_rna('C'), do: 'G'
  def to_rna('T'), do: 'A'
  def to_rna('A'), do: 'U'

  def to_rna(dna) when length(dna) > 1 do
    dna
    |> to_string()
    |> transcribe(nil)
  end

  defp transcribe([], accumulate), do: to_charlist(accumulate)

  defp transcribe(dna, accumulate) when is_bitstring(dna) do
    dna
    |> String.graphemes()
    |> transcribe(accumulate)
  end

  defp transcribe([head | tail] = dna, accumulate) when is_list(dna) do
    head = to_charlist(head)
    accumulate = "#{accumulate}#{to_rna(head)}"

    transcribe(tail, accumulate)
  end
end
