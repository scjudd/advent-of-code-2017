defmodule Captcha do

  @doc """
  The Captcha requires you to review a sequence of digits (your puzzle input)
  and find the sum of all digits that match the next digit in the list. The
  list is circular, so the digit after the last digit is the first digit in
  the list.
  """
  def sum1(input) when is_integer(input) do
    input
    |> Integer.digits()
    |> do_solve(1)
  end

  @doc """
  Now, instead of considering the next digit, it wants you to consider the
  digit halfway around the circular list. That is, if your list contains 10
  items, only include a digit in your sum if the digit 10/2 = 5 steps forward
  matches it. Fortunately, your list has an even number of elements.
  """
  def sum2(input) when is_integer(input) do
    digits = Integer.digits(input)
    offset = digits |> length() |> div(2)
    do_solve(digits, offset)
  end

  defp do_solve(digits, offset) do
    digits
    |> Stream.zip(rotate(digits, offset))
    |> Stream.map(&matching_value/1)
    |> Enum.sum()
  end

  defp rotate(digits, offset) do
    digits
    |> Stream.cycle()
    |> Stream.drop(offset)
    |> Enum.take(length(digits))
  end

  defp matching_value({x, x}), do: x
  defp matching_value({_, _}), do: 0
end
