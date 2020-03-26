defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  def count(l), do: handle_count(l, 0)
  def reverse(l), do: handle_reverse(l, [])
  def map(l, f), do: handle_map(l, f, [])
  def filter(l, f), do: handle_filter(l, f, [])
  def reduce(list, accumulator, function), do: handle_reduce(list, accumulator, function)
  def append(a, b), do: handle_append(ListOps.reverse(a), b)
  def concat(ll), do: handle_concat(ll, [])

  defp handle_count([], total), do: total

  defp handle_count([_head | tail], accumulator) do
    handle_count(tail, accumulator + 1)
  end

  defp handle_reverse([], accumulator), do: accumulator

  defp handle_reverse([head | tail] = _list, accumulator) do
    handle_reverse(tail, [head | accumulator])
  end

  defp handle_map([] = _list, _function, accumulator), do: ListOps.reverse(accumulator)

  defp handle_map([head | tail], function, accumulator) do
    handle_map(tail, function, [function.(head) | accumulator])
  end

  defp handle_filter([] = _list, _function, accumulator), do: ListOps.reverse(accumulator)

  defp handle_filter([head | tail], function, accumulator) do
    accumulator = if function.(head), do: [head | accumulator], else: accumulator
    handle_filter(tail, function, accumulator)
  end

  defp handle_reduce([], acumulator, _function), do: acumulator

  defp handle_reduce([head | tail], accumulator, function) do
    result = function.(head, accumulator)
    handle_reduce(tail, result, function)
  end

  defp handle_append(a, [] = _b), do: ListOps.reverse(a)
  defp handle_append([] = _a, b), do: b

  defp handle_append([head | tail], b) do
    handle_append(tail, [head | b])
  end

  defp handle_concat([], accumulator), do: accumulator

  defp handle_concat([head | tail], accumulator) do
    accumulator = ListOps.append(accumulator, head)
    handle_concat(tail, accumulator)
  end
end
