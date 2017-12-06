defmodule Passphrase do
  def num_valid(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&valid?/1)
    |> Enum.count(& &1)
  end

  def valid?(input) do
    input
    |> String.split()
    |> Enum.map(&sort_letters/1)
    |> Enum.sort()
    |> no_duplicates?()
  end

  defp no_duplicates?([m, m | _]), do: false
  defp no_duplicates?([_, n | rest]), do: no_duplicates?([n | rest])
  defp no_duplicates?([_]), do: true

  defp sort_letters(string) do
    string
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.join()
  end
end
