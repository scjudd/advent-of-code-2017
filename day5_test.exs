Code.load_file("day5.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule JumpMazeTest do
  use ExUnit.Case

  describe "num_steps/2" do
    test "given &next1/1, [0, 3, 0, 1, -3] -> 5" do
      assert JumpMaze.num_steps([0, 3, 0, 1, -3], &JumpMaze.next1/1) == 5
    end

    test "given &next2/1, [0, 3, 0, 1, -3] -> 10" do
      assert JumpMaze.num_steps([0, 3, 0, 1, -3], &JumpMaze.next2/1) == 10
    end
  end
end
