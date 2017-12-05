defmodule Spiral do

  def new, do: {0, 0, 0, 0, :right}

  def next({x, y, max_x, max_y, :right}) when x == max_x + 1,
    do: {x, y + 1, x, max_y, :up}
  def next({x, y, max_x, max_y, :right}),
    do: {x + 1, y, max_x, max_y, :right}
  def next({x, y, max_x, max_y, :up}) when y == max_y + 1,
    do: {x - 1, y, max_x, y, :left}
  def next({x, y, max_x, max_y, :up}),
    do: {x, y + 1, max_x, max_y, :up}
  def next({x, y, max_x, max_y, :left}) when abs(x) == max_x,
    do: {x, y - 1, max_x, max_y, :down}
  def next({x, y, max_x, max_y, :left}),
    do: {x - 1, y, max_x, max_y, :left}
  def next({x, y, max_x, max_y, :down}) when abs(y) == max_y,
    do: {x + 1, y, max_x, max_y, :right}
  def next({x, y, max_x, max_y, :down}),
    do: {x, y - 1, max_x, max_y, :down}

  def manhattan_distance(dest) do
    {x, y, _, _, _} =
      new()
      |> Stream.iterate(&next/1)
      |> Stream.take(dest)
      |> Enum.to_list()
      |> List.last()

    abs(x) + abs(y)
  end

  def first_sum_greater_than(n) do
    new()
    |> Stream.iterate(&next/1)
    |> Enum.reduce_while(%{}, &sum_less_than(n, &1, &2))
  end

  defp sum_less_than(n, {x, y, _, _, _}, sums) do
    sum = sum_neighbors({x, y}, sums)
    cond do
      sum > n -> {:halt, sum}
      true    -> {:cont, Map.put(sums, {x, y}, sum)}
    end
  end

  def sum_neighbors({0, 0}, _sums), do: 1

  def sum_neighbors({x, y}, sums) do
    {x, y}
    |> neighbors()
    |> Stream.map(&Map.get(sums, &1, 0))
    |> Enum.sum()
  end

  def neighbors({x, y}) do
    [{x - 1, y + 1}, {x, y + 1}, {x + 1, y + 1},
     {x - 1, y}, {x + 1, y},
     {x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1}]
  end
end
