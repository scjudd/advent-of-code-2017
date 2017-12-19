Code.load_file("day17.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule Day17Test do
  use ExUnit.Case

  test "part 1" do
    assert Day17.part1() == 1282
  end

  test "part 2" do
    assert Day17.part2() == 27650600
  end
end
