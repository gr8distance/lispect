defmodule Lispect.EvalrTest do
  use ExUnit.Case

  alias Lispect.Eval
  alias Lispect.Parser

  require IEx

  test "carは[h|_]のhを返す" do
    assert "(car (1 2 3 4))"
    |> Parser.parse
    |> Eval.evaluate == 1
  end

  test "cdrは[_|t]のtを返す" do
    assert "(cdr (1 2 3 4))"
    |> Parser.parse
    |> Eval.evaluate == [2, 3, 4]
  end

  test "atomは値がatomか返す" do
    assert "(atom 'hoge)"
    |> Parser.parse
    |> Eval.evaluate == true
  end

  test "eqは両辺が等しいか返す" do
    assert "(eq 1 1)"
    |> Parser.parse
    |> Eval.evaluate == true

    assert "(eq 1 2)"
    |> Parser.parse
    |> Eval.evaluate == false
  end

  test "consは引数のリストを連結する" do
    assert "(cons 1 2)"
    |> Parser.parse
    |> Eval.evaluate == [1|2]
  end

  test "基本的な四則演算" do
    assert "(+ 1 2)"
    |> Parser.parse
    |> Eval.evaluate == 3

    assert "(- 10 5)"
    |> Parser.parse
    |> Eval.evaluate == 5

    assert "(* 3 9)"
    |> Parser.parse
    |> Eval.evaluate == 27

    assert "(/ 18 9)"
    |> Parser.parse
    |> Eval.evaluate == 2

    assert "(mod 3 2)"
    |> Parser.parse
    |> Eval.evaluate == 1
  end
end
