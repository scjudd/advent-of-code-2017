Code.load_file("day6.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule ReallocationTest do
  use ExUnit.Case
  import Reallocation

  describe "num_cycles/1" do
    test "returns the number of redistribution cycles before an infinite loop is detected" do
      assert num_cycles([0, 2, 7, 0]) == 5
    end
  end

  describe "loop_size/1" do
    test "returns the number of redistribution cycles to complete a loop" do
      assert loop_size([0, 2, 7, 0]) == 4
    end
  end

  describe "distribute/1" do
    test "empties the largest bank and distributes it's blocks right to left" do
      assert distribute(new([0, 2, 7, 0])) == new([2, 4, 1, 2])
    end
  end

  describe "distribution/3" do
    test "returns a correct distribution map" do
      assert distribution(3, 3, 7) == %{0 => 2, 1 => 2, 2 => 1, 3 => 2}
    end
  end
end
