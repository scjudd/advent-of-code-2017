Code.load_file("day15.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule Day15Test do
  use ExUnit.Case

  test "part 1" do
    assert Day15.part1() == 573
  end

  test "part 2" do
    assert Day15.part2() == 294
  end
end
