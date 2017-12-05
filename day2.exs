defmodule Checksum do
  def part1(input) do
    spreadsheet(input, &min_max_difference/1)
  end

  def part2(input) do
    spreadsheet(input, &evenly_divisible/1)
  end

  def spreadsheet(input, fun) when is_binary(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&line(&1, fun))
    |> Enum.sum()
  end

  defp line(input, fun) when is_binary(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> fun.()
  end

  def min_max_difference(list) do
    {min, max} = Enum.min_max(list)
    max - min
  end

  def evenly_divisible(list) do
    [numerator | rest] = Enum.sort(list, &(&1 >= &2))
    case Enum.find(rest, &rem(numerator, &1) == 0) do
      nil -> evenly_divisible(rest)
      denominator -> div(numerator, denominator)
    end
  end
end
