defmodule Util do
  types = ~w[function nil integer binary bitstring list map float atom tuple pid port reference]
  for type <- types do
    def typeof(x) when unquote(:"is_#{type}")(x), do: unquote(type)
  end

  def to_int(i) when is_integer(i), do: i
  def to_int(s) when is_binary(s) do
    case Integer.parse(s) do
      {i, _} -> i
      :error -> :error
    end
  end

end
