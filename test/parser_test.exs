defmodule Lispect.ParserTest do
  use ExUnit.Case

  alias Lispect.Parser
  require IEx

  test "parse returns evaluatable S expressions" do
    assert Parser.parse("(print \"hello\")") == [:print, "hello"]
    assert Parser.parse("(echo (+ 1 (- 2 (* 3 (/ 4 1)))))") == [:echo, [:+, 1, [:-, 2, [:*, 3, [:/, 4, 1]]]]]
    assert Parser.parse("(print (+ 1 (- (/ 10 1) (* 2 10))))") == [:print, [:+, 1, [:-, [:/, 10, 1], [:*, 2, 10]]]]
  end

  test "tokenize convert LISP's atom from token" do
    num = "1"
    float = "1.1"
    str = "\"hello world\""
    atom = "'atom"

    assert Parser.tokenize(num) == 1
    assert Parser.tokenize(float) == 1.1
    assert Parser.tokenize(str) == "hello world"
    assert Parser.tokenize(atom) == :atom
  end
end
