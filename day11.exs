defmodule HexGrid do
  defp new do
    {0, 0, 0}
  end

  defp move(direction, {x, y, z}) do
    case direction do
      "n"  -> {x, y + 1, z - 1}
      "s"  -> {x, y - 1, z + 1}
      "ne" -> {x + 1, y, z - 1}
      "sw" -> {x - 1, y, z + 1}
      "nw" -> {x - 1, y + 1, z}
      "se" -> {x + 1, y - 1, z}
    end
  end

  defp move_tracking_max_distance(direction, {{x, y, z}, prev}) do
    new_position = move(direction, {x, y, z})
    max_distance = max(prev, calc_distance(new_position))
    {new_position, max_distance}
  end

  defp calc_distance({x, y, z}) do
    [x, y, z] |> Stream.map(&abs/1) |> Enum.max()
  end

  def distance(steps) do
    steps
    |> Enum.reduce(new(), &move/2)
    |> calc_distance()
  end

  def max_distance(steps) do
    steps
    |> Enum.reduce({new(), 0}, &move_tracking_max_distance/2)
    |> elem(1)
  end
end

defmodule Day11 do
  defp load_directions do
    "day11_input.txt"
    |> File.read!()
    |> String.trim()
    |> String.split(",")
  end

  def part1 do
    load_directions() |> HexGrid.distance()
  end

  def part2 do
    load_directions() |> HexGrid.max_distance()
  end
end
