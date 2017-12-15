defmodule Generators do
  def score({a, b}, n, :simple) do
    do_score({a, b}, n, &next_simple/1)
  end

  def score({a, b}, n, :aligned) do
    do_score({a, b}, n, &next_aligned/1)
  end

  defp do_score({a, b}, n, next_fun) do
    {a, b}
    |> next_simple()
    |> Stream.iterate(next_fun)
    |> Stream.take(n)
    |> Stream.map(&lower_16/1)
    |> Enum.count(fn {a, b} -> a == b end)
  end

  defp next_simple({a, b}) do
    {next(:a, a), next(:b, b)}
  end

  defp next_aligned({a, b}) do
    {next_aligned(:a, a), next_aligned(:b, b)}
  end

  defp next_aligned(:a, a) do
    result = next(:a, a)
    if rem(result, 4) != 0, do: next_aligned(:a, result), else: result
  end

  defp next_aligned(:b, b) do
    result = next(:b, b)
    if rem(result, 8) != 0, do: next_aligned(:b, result), else: result
  end

  defp next(:a, a), do: rem(a * 16807, 2147483647)
  defp next(:b, b), do: rem(b * 48271, 2147483647)

  defp lower_16({a, b}) do
    {<<a::little-16>>, <<b::little-16>>}
  end
end

defmodule Day15 do
  @input {634, 301}

  def part1 do
    Generators.score(@input, 40_000_000, :simple)
  end

  def part2 do
    Generators.score(@input, 5_000_000, :aligned)
  end
end
