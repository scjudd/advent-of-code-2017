defmodule Firewall do
  def severity(ranges) do
    Enum.reduce(ranges, 0, fn ({depth, range}, score) ->
      case caught?({depth, range}) do
        true  -> score + depth * range
        false -> score
      end
    end)
  end

  def delay(ranges) do
    delay(ranges, 0)
  end

  defp delay(ranges, offset) do
    case Enum.any?(ranges, &caught?(&1, offset)) do
      true  -> delay(ranges, offset + 1)
      false -> offset
    end
  end

  defp caught?({depth, range}, offset \\ 0) do
    rem(depth + offset, range * 2 - 2) == 0
  end
end

defmodule Day13 do
  def part1 do
    build_mapping() |> Firewall.severity()
  end

  def part2 do
    build_mapping() |> Firewall.delay()
  end

  defp build_mapping do
    "day13_input.txt" |> File.stream!() |> Map.new(&parse/1)
  end

  defp parse(line) do
    [k, v] = line |> String.trim() |> String.split(": ")
    {String.to_integer(k), String.to_integer(v)}
  end
end
