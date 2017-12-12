defmodule Registers do
  @operators ~w(< <= > >= == !=)

  def run_script(filename) do
    {registers, all_time_max} =
      filename
      |> File.stream!()
      |> Stream.map(&parse/1)
      |> Enum.reduce({%{}, 0}, &update(&2, &1))

    current_max = registers |> Enum.max_by(&elem(&1, 1)) |> elem(1)

    {registers, all_time_max}
  end

  def parse(line) do
    [reg1, inst, amt, "if", reg2, op, val] = String.split(line)
    {{reg1, inst, amt}, {reg2, op, val}}
  end

  def update({map, biggest}, {{reg, inst, amt}, condition}) do
    amt = String.to_integer(amt)
    updated_map = case {inst, check(map, condition)} do
      {"inc", true} -> Map.update(map, reg,  amt, fn(x) -> x + amt end)
      {"dec", true} -> Map.update(map, reg, -amt, fn(x) -> x - amt end)
      {_, false} -> map
    end
    updated_biggest = max(biggest, Map.get(updated_map, reg, 0))
    {updated_map, updated_biggest}
  end

  def check(state, {reg, op, val}) when op in @operators do
    args = [Map.get(state, reg, 0), String.to_integer(val)]
    apply(Kernel, String.to_atom(op), args)
  end
end

defmodule Day8 do
  def part1 do
    {registers, _} = Registers.run_script("day8_input.txt")
    registers |> Enum.max_by(&elem(&1, 1)) |> elem(1)
  end

  def part2 do
    "day8_input.txt" |> Registers.run_script() |> elem(1)
  end
end
