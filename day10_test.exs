Code.load_file("day10.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule CircularListTest do
  use ExUnit.Case

  test "from beginning of list, non-wrapping" do
    result =
      0..4
      |> Enum.to_list()
      |> CircularList.new()
      |> CircularList.skip(0)
      |> CircularList.select(3)
      |> CircularList.update_selection(&Enum.reverse/1)
      |> CircularList.to_list()

    assert result == [2, 1, 0, 3, 4]
  end

  test "from middle of list, non-wrapping" do
    result =
      0..4
      |> Enum.to_list()
      |> CircularList.new()
      |> CircularList.skip(1)
      |> CircularList.select(3)
      |> CircularList.update_selection(&Enum.reverse/1)
      |> CircularList.to_list()

    assert result == [0, 3, 2, 1, 4]
  end

  test "from end of list, wrapping" do
    result =
      0..4
      |> Enum.to_list()
      |> CircularList.new()
      |> CircularList.skip(3)
      |> CircularList.select(3)
      |> CircularList.update_selection(&Enum.reverse/1)
      |> CircularList.to_list()

    assert result == [3, 1, 2, 0, 4]
  end
end

defmodule KnotHashTest do
  use ExUnit.Case

  describe "compute/3" do
    test "single round" do
      result =
        0..4
        |> Enum.to_list()
        |> KnotHash.compute([3, 4, 1, 5])
        
      assert result == [3, 4, 2, 1, 0]
    end

    test "multiple rounds" do
      result =
        0..4
        |> Enum.to_list()
        |> KnotHash.compute([3, 4, 1, 5], 64)
        
      assert result == [3, 4, 0, 1, 2]
    end
  end
end

defmodule Day10Test do
  use ExUnit.Case

  test "part 1" do
    assert Day10.part1() == 826
  end

  test "part 2" do
    assert Day10.part2() == "d067d3f14d07e09c2e7308c3926605c4"
  end
end
