defmodule Reallocation do
  def new(banks) do
    {length(banks) - 1, to_map(banks)}
  end

  defp to_map(list) do
    list
    |> Stream.with_index()
    |> Enum.into(%{}, fn {v, k} -> {k, v} end)
  end

  def num_cycles(banks) do
    banks
    |> new()
    |> Stream.iterate(&distribute/1)
    |> Enum.reduce_while(MapSet.new(), fn (x, set) ->
      case MapSet.member?(set, x) do
        true  -> {:halt, MapSet.size(set)}
        false -> {:cont, MapSet.put(set, x)}
      end
    end)
  end

  def loop_size(banks) do
    banks
    |> new()
    |> Stream.iterate(&distribute/1)
    |> Stream.with_index()
    |> Enum.reduce_while(%{}, fn ({x, index}, map) ->
      case Map.has_key?(map, x) do
        true  -> {:halt, index - Map.get(map, x)}
        false -> {:cont, Map.put(map, x, index)}
      end
    end)
  end

  def distribute({max_index, banks}) do
    {index, blocks} =
      banks
      |> Enum.max_by(fn {_, v} -> v end)

    new_banks =
      banks
      |> Map.replace(index, 0)
      |> Map.merge(distribution(index + 1, max_index, blocks), fn (_, x, y) -> x + y end)

    {max_index, new_banks}
  end

  def distribution(start_index, max_index, n) do
    0..max_index
    |> Stream.cycle()
    |> Stream.drop(start_index)
    |> Stream.take(n)
    |> Enum.reduce(%{}, fn (index, map) -> Map.update(map, index, 1, &(&1 + 1)) end)
  end
end
