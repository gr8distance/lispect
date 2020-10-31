defmodule Lispect.Eval do
  require IEx

  def evaluate([func|args]) do
    basic_funcs()[func].(args)
  end

  def basic_funcs do
    basic_funcs = %{
      +:  fn args -> Enum.sum(args) end,
      -: fn [h|t] -> Enum.reduce(t, h, fn x, acm -> acm - x end) end,
      *: fn [h|t] -> Enum.reduce(t, h, fn x, acm -> acm * x end) end,
      /: fn [h|t] -> Enum.reduce(t, h, fn x, acm -> acm / x end) end,
      mod: fn [h|t] -> Enum.reduce(t, h, fn x, acm -> rem(acm, x) end) end
    }
  end
end
