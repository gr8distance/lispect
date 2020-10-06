defmodule LispectTest do
  use ExUnit.Case
  doctest Lispect

  test "greets the world" do
    assert Lispect.hello() == :world
  end
end
