Code.load_file("day13.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule FirewallTest do
  use ExUnit.Case

  test "delay/1" do
    mapping = %{0 => 3, 1 => 2, 4 => 4, 6 => 4}
    assert Firewall.delay(mapping) == 10
  end
end

defmodule Day13Test do
  use ExUnit.Case

  test "part 1" do
    assert Day13.part1() == 1876
  end

  test "part 2" do
    assert Day13.part2() == 3964778
  end
end
