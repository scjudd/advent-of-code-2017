Code.load_file("day3.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule SpiralTest do
  use ExUnit.Case

  describe "manhattan_distance/1" do
    test "returns the Manhattan Distance from the spiral memory access port to the destination" do
      assert Spiral.manhattan_distance(2) == 1
      assert Spiral.manhattan_distance(3) == 2
      assert Spiral.manhattan_distance(13) == 4
      assert Spiral.manhattan_distance(17) == 4
    end
  end

  describe "first_sum_greater_than/1" do
    test "returns the first neighbor sum greater than the provided value" do
      assert Spiral.first_sum_greater_than(2) == 4
      assert Spiral.first_sum_greater_than(3) == 4
      assert Spiral.first_sum_greater_than(13) == 23
      assert Spiral.first_sum_greater_than(17) == 23
    end
  end
end
