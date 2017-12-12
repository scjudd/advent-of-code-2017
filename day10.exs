defmodule CircularList do
  @moduledoc """
  A CircularList is a functional data structure which allows you to update some
  subset of a list, wrapping around to the beginning if your selection extends
  past the end. It is particularly useful for solving some of the 2017 Advent
  of Code challenges.
  """

  alias CircularList, as: CL

  defstruct skip: 0, list: {[], 0}, head: {[], 0}, selection: {[], 0}

  @doc "Create a new CircularList from a list"
  def new(list) do
    len = length(list)
    %CL{list: {list, len}, selection: {list, len}}
  end

  @doc "Skip the first (N % length) elements in the source list"
  def skip(%CL{list: {_, len}, selection: {_, num_selected}} = clist, n) when n >= 0 do
    %CL{clist | skip: rem(n, len)} |> select(num_selected)
  end

  @doc """
  Select the next N elements in the source list, wrapping around to the
  beginning if necessary
  """
  def select(%CL{skip: skip, list: {list, len}} = clist, n) when n >= 0 and n <= len do
    cycle = Stream.cycle(list)
    head = cycle |> Stream.drop(skip + n) |> Enum.take(len - n)
    head_pos = rem(skip + n, len)
    selection = cycle |> Stream.drop(skip) |> Enum.take(n)
    %CL{clist | head: {head, head_pos}, selection: {selection, n}}
  end

  @doc """
  Given a CircularList with a selection and an updater function, update the
  selection with the result of calling `fun` on it
  """
  def update_selection(%CL{selection: {selection, len}} = clist, fun) do
    updated = fun.(selection)
    if length(updated) != len, do: raise("function must not alter selection length")
    %CL{clist | selection: {updated, len}} |> save()
  end

  defp save(%CL{list: {_, len}, head: {head, head_pos}, selection: {selection, _}} = clist) do
    updated =
      [head, selection]
      |> Stream.concat()
      |> Stream.cycle()
      |> Stream.drop(len - head_pos)
      |> Enum.take(len)

    %CL{clist | list: {updated, len}}
  end

  @doc "Convert a CircularList to a regular list"
  def to_list(%CL{list: {list, _}}) do
    list
  end
end

defmodule KnotHash do
  def compute(list, lengths, rounds \\ 1) do
    start = {0, 0, CircularList.new(list)}

    {_, _, computed} =
      Enum.reduce(1..rounds, start, fn (_, start) ->
        Enum.reduce(lengths, start, &do_compute/2)
      end)

    CircularList.to_list(computed)
  end

  defp do_compute(len, {pos, skip, clist}) do
    updated_clist =
      clist
      |> CircularList.skip(pos)
      |> CircularList.select(len)
      |> CircularList.update_selection(&Enum.reverse/1)

    {pos + skip + len, skip + 1, updated_clist}
  end

  def condense(sparse_hash) do
    sparse_hash
    |> Stream.chunk_every(16)
    |> Enum.map(&xor_bytes/1)
  end

  defp xor_bytes(bytes) do
    use Bitwise, skip_operators: true
    Enum.reduce(bytes, &bxor/2)
  end

  def hex_encode(hash) do
    hash |> IO.iodata_to_binary() |> Base.encode16(case: :lower)
  end
end

defmodule Day10 do
  @input "120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113"

  def part1 do
    lengths = @input |> String.split(",") |> Enum.map(&String.to_integer/1)
    [x, y | _rest] = 0..255 |> Enum.to_list() |> KnotHash.compute(lengths)
    x * y
  end

  def part2 do
    lengths = @input |> String.to_charlist() |> Enum.concat([17, 31, 73, 47, 23])

    0..255
    |> Enum.to_list()
    |> KnotHash.compute(lengths, 64)
    |> KnotHash.condense()
    |> KnotHash.hex_encode()
  end
end
