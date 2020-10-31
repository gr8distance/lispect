defmodule Lispect.ParserTest do
  use ExUnit.Case

  alias Lispect.Parser
  require IEx

  test "parse returns evaluatable S expressions" do
    assert Parser.parse("(print \"hello\")") == [:print, "hello"]
    assert Parser.parse("(echo (+ 1 (- 2 (* 3 (/ 4 1)))))") == [:echo, [:+, 1, [:-, 2, [:*, 3, [:/, 4, 1]]]]]
    assert Parser.parse("(print (+ 1 (- (/ 10 1) (* 2 10))))") == [:print, [:+, 1, [:-, [:/, 10, 1], [:*, 2, 10]]]]
  end

  # test "read_from will parse tokens" do
  #   simple_tokens = "(print \"hello\")"
  #   |> Parser.tokenize
  #   assert Parser.read_from(simple_tokens) == [[:print, "hello"]]
  #
  #   complicated_tokens = "(print (+ 1 (- 10 20)))"
  #   |> Parser.tokenize
  #   assert Parser.read_from(complicated_tokens) == [[:print, [:+, 1, [:-, 10, 20]]]]
  # end
  #
  # test "tokenize make token from LISP code" do
  #   simple_code = "(print 'hello)"
  #   assert Parser.tokenize(simple_code) == ["(", "print", "'hello", ")"]
  #
  #   complicated_code = "(print (+ 'a' 'b'))"
  #   assert Parser.tokenize(complicated_code) == ["(", "print", "(", "+", "'a'", "'b'", ")", ")"]
  # end
  #
  # test "to_atom convert LISP's atom from token" do
  #   num = "1"
  #   float = "1.1"
  #   str = "\"hello world\""
  #   atom = "'atom"
  #
  #   assert Parser.to_atom(num) == 1
  #   assert Parser.to_atom(float) == 1.1
  #   assert Parser.to_atom(str) == "hello world"
  #   assert Parser.to_atom(atom) == :atom
  # end
end
