Code.load_file("day9.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule StreamProcessingTest do
  use ExUnit.Case
  alias StreamProcessing, as: SP

  def score(string) do
    string
    |> String.graphemes()
    |> Enum.reduce(SP.new(), &SP.next(&2, &1))
    |> SP.score()
  end

  def garbage(string) do
    string
    |> String.graphemes()
    |> Enum.reduce(SP.new(), &SP.next(&2, &1))
    |> SP.garbage()
  end

  test "scoring" do
    assert score("{}") == 1
    assert score("{{{}}}") == 6
    assert score("{{},{}}") == 5
    assert score("{{{},{},{{}}}}") == 16
    assert score("{<a>,<a>,<a>,<a>}") == 1
    assert score("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9
    assert score("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9
    assert score("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
  end

  test "garbage counting" do
    assert garbage("<>") == 0
    assert garbage("<random characters>") == 17
    assert garbage("<<<<>") == 3
    assert garbage("<{!>}>") == 2
    assert garbage("<!!>") == 0
    assert garbage("<!!!>>") == 0
    assert garbage("<{o\"i!a,<{i<a>") == 10
  end
end
