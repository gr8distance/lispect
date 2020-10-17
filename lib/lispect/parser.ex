defmodule Lispect.Parser do
  require IEx

  def parse(code) do
    code
    |> tokenize
    |> read_from
  end

  def tokenize(str) do
    str
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split(" ")
    |> Enum.reject(& &1 == "")
  end

  def while(list, expr, f), do: while(list, expr, f, [])
  def while([h|t], expr, f, acc), do: while(t, expr, f, (acc ++ [f.(h, expr)]))

  def read_from(tokens), do: read_from(tokens, [])
  def read_from([], acm), do: acm
  def read_from(["("|tokens], acm) do
    nested_tokens = tokens
    |> Enum.take_while(& &1 != ")")

    res = read_from(nested_tokens)
    hoge = tokens
    |> Enum.slice((length(nested_tokens) + 1)..-1)
    hoge
    |> read_from(Enum.concat([acm, [res]]))
  end
  def read_from([], acm), do: acm
  def read_from([")"], acm), do: acm
  def read_from([")"|tokens], acm) do
    tokens
    |> tl
    |> __MODULE__.read_from(acm)
  end
  def read_from([h|t], acm), do: read_from(t, (acm ++ [to_atom(h)]))

  def to_atom(token) do
    cond do
      String.match?(token, ~r/[+-]?\d+/) ->
        to_number(token)
      String.match?(token, ~r/\".*\"/) ->
        token
        |> String.replace("\"", "")
      true ->
        token
        |> String.replace("'", "")
        |> String.to_atom
    end
  end

  defp to_number(token) do
    try do
      String.to_integer(token)
    rescue
      e in ArgumentError -> String.to_float(token)
    end
  end
end


    # nested_expressions = tokens
    # |> Enum.take_while(& &1 != ")")
    #
    # IEx.pry
    # new_tokens = tokens
    # |> Enum.slice(length(nested_expressions)..-1)
    # new_tokens
    # |> read_from(acm ++ [read_from(nested_expressions, [])])
