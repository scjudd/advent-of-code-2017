defmodule Permutation do
  @names "abcdefghijklmnop"
  @len String.length(@names)
  @init @names |> String.graphemes() |> Stream.with_index() |> Enum.unzip()

  def parse_instruction(<<"s", num :: binary>>) do
    {:spin, String.to_integer(num)}
  end

  def parse_instruction(<<"x", args :: binary>>) do
    [x, y] = args |> String.split("/") |> Enum.map(&String.to_integer/1)
    {:exchange, x, y}
  end

  def parse_instruction(<<"p", args :: binary>>) do
    [a, b] = args |> String.split("/")
    {:partner, a, b}
  end

  def apply_instruction({names, positions}, {:spin, num}) do
    {names, Enum.map(positions, &rem(&1 + num, @len))}
  end

  def apply_instruction({names, positions}, {:exchange, x, y}) do
    {names, Enum.map(positions, swap(x, y))}
  end

  def apply_instruction({names, positions}, {:partner, a, b}) do
    {Enum.map(names, swap(a, b)), positions}
  end

  defp swap(a, b) do
    fn
      ^a -> b
      ^b -> a
       c -> c
    end
  end

  def run(instructions, iterations \\ 1) do
    run(instructions, @init, iterations)
  end

  defp run(_instructions, last, 0) do
    render(last)
  end

  defp run(instructions, last, n) do
    result = Enum.reduce(instructions, last, &apply_instruction(&2, &1))
    run(instructions, result, n - 1)
  end

  def render({names, positions}) do
    [names, positions]
    |> Stream.zip()
    |> Enum.sort_by(fn {_, pos} -> pos end)
    |> Stream.map(fn {name, _} -> name end)
    |> Enum.join("")
  end

  def calc_cycle(instructions) do
    calc_cycle(instructions, @init, 0)
  end

  defp calc_cycle(_instructions, @init, n) when n > 0 do
    n
  end

  defp calc_cycle(instructions, last, n) do
    result = Enum.reduce(instructions, last, &apply_instruction(&2, &1))
    calc_cycle(instructions, result, n + 1)
  end
end

defmodule Day16 do
  def load_instructions do
    "day16_input.txt"
    |> File.read!()
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&Permutation.parse_instruction/1)
  end

  def part1 do
    load_instructions() |> Permutation.run()
  end

  def part2 do
    instructions = load_instructions()
    cycles_at = Permutation.calc_cycle(instructions)
    iterations = rem(1_000_000_000, cycles_at)
    Permutation.run(instructions, iterations)
  end
end
