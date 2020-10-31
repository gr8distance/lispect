defmodule Lispect.EvalrTest do
  use ExUnit.Case

  alias Lispect.Eval
  alias Lispect.Parser

  require IEx

  test ".evaluateに実装された基本的な四則演算" do
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
  end
end
