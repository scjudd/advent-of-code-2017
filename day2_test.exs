Code.load_file("day2.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule ChecksumTest do
  use ExUnit.Case

  describe "min_max_difference/1" do
    test "[5, 1, 9, 5] -> 8" do
      assert Checksum.min_max_difference([5, 1, 9, 5]) == 8
    end

    test "[7, 5, 3] -> 4" do
      assert Checksum.min_max_difference([7, 5, 3]) == 4
    end

    test "[2, 4, 6, 8] -> 6" do
      assert Checksum.min_max_difference([2, 4, 6, 8]) == 6
    end
  end

  describe "evenly_divisible/1" do
    test "[5, 9, 2, 8] -> 4" do
      assert Checksum.evenly_divisible([5, 9, 2, 8]) == 4
    end

    test "[9, 4, 7, 3] -> 3" do
      assert Checksum.evenly_divisible([9, 4, 7, 3]) == 3
    end

    test "[3, 8, 6, 5] -> 2" do
      assert Checksum.evenly_divisible([3, 8, 6, 5]) == 2
    end
  end

  describe "spreadsheet/2" do
    test "computes the checksum, according to the given strategy" do
      sheet1 = """
      5 1 9 5
      7 5 3
      2 4 6 8
      """
      assert Checksum.spreadsheet(sheet1, &Checksum.min_max_difference/1) == 18

      sheet2 = """
      5 9 2 8
      9 4 7 3
      3 8 6 5
      """
      assert Checksum.spreadsheet(sheet2, &Checksum.evenly_divisible/1) == 9
    end
  end
end
