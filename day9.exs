defmodule StreamProcessing do
  def new do
    {0, 0, 0, :accept}
  end

  def next({level, score, garbage, {prev, :escape}}, _) do
    {level, score, garbage, prev}
  end

  def next({level, score, garbage, state}, "!") do
    {level, score, garbage, {state, :escape}}
  end

  def next({level, score, garbage, :accept}, "{") do
    new_level = level + 1
    {new_level, score + new_level, garbage, :accept}
  end

  def next({level, score, garbage, :accept}, "}") when level > 0 do
    new_level = level - 1
    {new_level, score, garbage, :accept}
  end

  def next({level, score, garbage, :accept}, "<") do
    {level, score, garbage, :garbage}
  end

  def next({level, score, garbage, :accept}, _) do
    {level, score, garbage, :accept}
  end

  def next({level, score, garbage, :garbage}, ">") do
    {level, score, garbage, :accept}
  end

  def next({level, score, garbage, :garbage}, _) do
    {level, score, garbage + 1, :garbage}
  end

  def score({_level, score, _garbage, _state}) do
    score
  end

  def garbage({_leve, _score, garbage, _state}) do
    garbage
  end
end

defmodule Day9 do
  alias StreamProcessing, as: SP

  def part1 do
    "day9_input.txt"
    |> File.stream!([], 1)
    |> Enum.reduce(SP.new(), &SP.next(&2, &1))
    |> SP.score()
  end

  def part2 do
    "day9_input.txt"
    |> File.stream!([], 1)
    |> Enum.reduce(SP.new(), &SP.next(&2, &1))
    |> SP.garbage()
  end
end
