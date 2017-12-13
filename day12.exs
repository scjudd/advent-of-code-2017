defmodule Graph do
  def new do
    %{}
  end

  def connect(graph, {node1, node2}) do
    connect(graph, node1, node2)
  end

  def connect(graph, node1, node2) do
    graph
    |> Map.update(node1, MapSet.new([node2]), &MapSet.put(&1, node2))
    |> Map.update(node2, MapSet.new([node1]), &MapSet.put(&1, node1))
  end

  def connections(graph, node) do
    connections(graph, node, MapSet.new())
  end

  defp connections(graph, node, prev) do
    found = graph |> Map.fetch!(node) |> MapSet.union(prev)
    cond do
      found == prev -> found
      true -> Enum.reduce(found, found, &connections(graph, &1, &2))
    end
  end

  def groups(graph) do
    {found_groups, _} =
      Enum.reduce(graph, {[], MapSet.new()}, fn ({node, _}, {groups, skip}) ->
        case MapSet.member?(skip, node) do
          true -> {groups, skip}
          false ->
            node_connections = connections(graph, node)
            new_skip = skip |> MapSet.put(node) |> MapSet.union(node_connections)
            {[node_connections | groups], new_skip}
        end
      end)

    found_groups
  end
end

defmodule Day12 do
  defp build_graph do
    "day12_input.txt"
    |> File.stream!()
    |> Stream.map(&parse/1)
    |> Stream.concat()
    |> Enum.reduce(Graph.new(), &Graph.connect(&2, &1))
  end

  defp parse(line) do
    [node, connections] = line |> String.trim() |> String.split(" <-> ")

    connections
    |> String.split(", ")
    |> Stream.map(&String.to_integer/1)
    |> Enum.map(&{String.to_integer(node), &1})
  end

  def part1 do
    build_graph()
    |> Graph.connections(0)
    |> MapSet.size()
  end

  def part2 do
    build_graph()
    |> Graph.groups()
    |> length()
  end
end
