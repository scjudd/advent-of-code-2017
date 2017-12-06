defmodule JumpMaze do
  def new(list) when is_list(list) do
    instructions =
      list
      |> Stream.with_index()
      |> Enum.into(%{}, fn {v, k} -> {k, v} end)

    {0, instructions}
  end

  def next1({n, instructions}) do
    case Map.get(instructions, n) do
      nil -> :end
      offset -> {n + offset, Map.replace(instructions, n, offset + 1)}
    end
  end

  def next2({n, instructions}) do
    case Map.get(instructions, n) do
      nil -> :end
      offset when offset >= 3 -> {n + offset, Map.replace(instructions, n, offset - 1)}
      offset -> {n + offset, Map.replace(instructions, n, offset + 1)}
    end
  end

  def num_steps(list, fun) do
    list
    |> new()
    |> fun.()
    |> Stream.iterate(fun)
    |> Stream.take_while(& &1 != :end)
    |> Enum.count()
  end
end
