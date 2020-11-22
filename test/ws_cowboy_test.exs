defmodule WsCowboyTest do
  use ExUnit.Case
  doctest WsCowboy

  test "greets the world" do
    assert WsCowboy.hello() == :world
  end
end
