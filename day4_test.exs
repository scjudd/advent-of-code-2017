Code.load_file("day4.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule PassphraseTest do
  use ExUnit.Case

  describe "valid?/1" do
    test "aa bb cc dd ee -> true" do
      assert Passphrase.valid?("aa bb cc dd ee")
    end

    test "aa bb cc dd aa -> false" do
      refute Passphrase.valid?("aa bb cc dd aa")
    end

    test "aa bb cc dd aaa -> true" do
      assert Passphrase.valid?("aa bb cc dd aaa")
    end

    test "abcde fghij -> true" do
      assert Passphrase.valid?("abcde fghij")
    end

    test "abcde xyz ecdab -> false" do
      refute Passphrase.valid?("abcde xyz ecdab")
    end

    test "a ab abc abd abf abj -> true" do
      assert Passphrase.valid?("a ab abc abd abf abj")
    end

    test "iiii oiii ooii oooi oooo -> true" do
      assert Passphrase.valid?("iiii oiii ooii oooi oooo")
    end

    test "oiii ioii iioi iiio -> false" do
      refute Passphrase.valid?("oiii ioii iioi iiio")
    end
  end
end
