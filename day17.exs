defmodule Spinlock do
  def next1({list, pos, len}, steps) do
    new_pos = rem(pos + steps, len) + 1
    new_list = List.insert_at(list, new_pos, len)
    {new_list, new_pos, len + 1}
  end

  def next2({0, 0, 1}) do
    0
  end

  def next2({last, pos, len}, steps) do
    case rem(pos + steps, len) + 1 do
      1 -> {len, 1, len + 1}
      n -> {last, n, len + 1}
    end
  end

  def run(:part1, steps, iterations) do
    {list, pos, len} = run(steps, {[0], 0, 1}, &next1/2, iterations)
    next_pos = rem(pos + 1, len)
    Enum.at(list, next_pos)
  end

  def run(:part2, steps, iterations) do
    run(steps, {0, 0, 1}, &next2/2, iterations) |> elem(0)
  end

  defp run(_steps, last, _fun, 0) do
    last
  end

  defp run(steps, last, fun, n) do
    run(steps, fun.(last, steps), fun, n - 1)
  end
end

defmodule Day17 do
  @input 335

  def part1 do
    Spinlock.run(:part1, @input, 2017)
  end

  def part2 do
    Spinlock.run(:part2, @input, 50_000_000)
  end
end
