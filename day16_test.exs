Code.load_file("day16.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule Day16Test do
  use ExUnit.Case

  test "part 1" do
    assert Day16.part1() == "ionlbkfeajgdmphc"
  end

  test "part 2" do
    assert Day16.part2() == "fdnphiegakolcmjb"
  end
end
