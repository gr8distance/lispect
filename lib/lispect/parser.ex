defmodule Lispect.Parser do
  require IEx

  def parse(code) do
    code
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split(" ")
    |> Enum.reject(& &1 == "")
    |> Enum.map(fn token -> tokenize(token) end)
    |> read_from
    |> format_s_expr
  end

  def format_s_expr([h|_]) when is_list(h), do: h
  def format_s_expr(s_expr), do: s_expr

  def read_from([:"("|tokens]), do: read_from(tokens)
  def read_from([token|tokens]), do: read_from(tokens, [token])
  def read_from([], acm), do: acm
  def read_from([:")"], acm), do: acm
  def read_from([:")"|[:"("|tokens]], acm), do: [acm] ++ [read_from(tokens)]
  def read_from([:"("|tokens], acm) do
    s_expr = read_from(tokens)
    if is_list_in_list?(s_expr) do
      acm ++ s_expr
    else
      acm ++ [s_expr]
    end
  end
  def read_from([:")"|tokens], acm) do
    if Enum.all?(tokens, fn t -> t == :")" end) do
      acm
    else
      read_from(tokens, acm)
    end
  end
  def read_from([token|tokens], acm) do
    [last|first] = Enum.reverse(acm)
    if is_list(last) do
      read_from(tokens, Enum.reverse([[token] ++ last] ++ first))
    else
      read_from(tokens, (acm ++ [token]))
    end
  end

  def tokenize(token) do
    cond do
      String.match?(token, ~r/[+-]?\d+/) ->
        to_number(token)
      String.match?(token, ~r/\".*\"/) ->
        String.replace(token, "\"", "")
      String.match?(token, ~r/^\'.*\'$/) ->
        String.replace(token, "'", "")
      true ->
        String.replace(token, "'", "") |> String.to_atom
    end
  end

  def to_atom(token) do
    String.match?(token, ~r/^\'.*\'$/)
  end

  defp to_number(token) do
    try do
      String.to_integer(token)
    rescue
      ArgumentError -> String.to_float(token)
    end
  end

  defp is_list_in_list?([h|_]) when is_list(h), do: true
  defp is_list_in_list?(_), do: false
end
