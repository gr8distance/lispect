defmodule Lispect.Parser do
  require IEx

  def parse(code) do
    code
    |> tokenize
    # |> read_from
  end

  def tokenize(str) do
    str
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split(" ")
    |> Enum.reject(& &1 == "")
  end

  def read_from([]), do: raise "error"
  def read_from(["("|tokens]) do
    hoge = tokens
    |> Enum.take_while(& &1 != ")")
    0..length(hoge)
    |> Enum.to_list
    |> Enum.map(& read_from())
  end
  def read_from([")"|tokens]) do
    tokens
    |> tl
    |> read_from
  end
  def read_from([token|_]), do: to_atom(token)

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
