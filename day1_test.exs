Code.load_file("day1.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule CaptchaTest do
  use ExUnit.Case

  describe "sum1/1" do
    test "1122 -> 3" do
      assert Captcha.sum1(1122) == 3
    end

    test "1111 -> 4" do
      assert Captcha.sum1(1111) == 4
    end

    test "1234 -> 0" do
      assert Captcha.sum1(1234) == 0
    end

    test "91212129 -> 9" do
      assert Captcha.sum1(91212129) == 9
    end
  end

  describe "sum2/1" do
    test "1212 -> 6" do
      assert Captcha.sum2(1212) == 6
    end

    test "1221 -> 0" do
      assert Captcha.sum2(1221) == 0
    end

    test "123425 -> 4" do
      assert Captcha.sum2(123425) == 4
    end

    test "123123 -> 12" do
      assert Captcha.sum2(123123) == 12
    end

    test "12131415 -> 4" do
      assert Captcha.sum2(12131415) == 4
    end
  end
end
