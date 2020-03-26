defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()

  def numeral(number) when number >= 1000, do: complex_convertion(number, "M", 1000)
  def numeral(number) when number >= 900, do: complex_convertion(number, "CM", 900)
  def numeral(number) when number >= 500, do: complex_convertion(number, "D", 500)
  def numeral(number) when number >= 400, do: complex_convertion(number, "CD", 400)
  def numeral(number) when number >= 160, do: complex_convertion(number, "CLX", 160)
  def numeral(number) when number >= 140, do: complex_convertion(number, "CXL", 140)
  def numeral(number) when number >= 90, do: complex_convertion(number, "XC", 90)
  def numeral(number) when number >= 50, do: complex_convertion(number, "L", 50)
  def numeral(number) when number >= 40, do: complex_convertion(number, "XL", 40)
  def numeral(number) when number >= 10, do: complex_convertion(number, "X", 10)
  def numeral(9), do: "IX"
  def numeral(number) when number >= 5, do: complex_convertion(number, "V", 5)
  def numeral(4), do: "IV"
  def numeral(number), do: repeat("I", number)

  defp repeat(char, total), do: String.duplicate(char, total)

  defp complex_convertion(number, roman_base, weight) do
    roman_base <> numeral(number - weight)
  end
end

# defmodule RomanNumerals do
#   @conversions [
#     {"M", 1000},
#     {"CM", 900},
#     {"D", 500},
#     {"CD", 400},
#     {"C", 100},
#     {"XC", 90},
#     {"L", 50},
#     {"XL", 40},
#     {"X", 10},
#     {"IX", 9},
#     {"V", 5},
#     {"IV", 4},
#     {"I", 1}
#   ]

#   def numeral(0), do: ""

#   def numeral(number) do
#     {roman, arabic} =
#       Enum.find(@conversions, fn {roman, arabic} ->
#         number >= arabic
#       end)

#     roman <> numeral(number - arabic)
#   end
# end
