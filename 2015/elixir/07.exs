defmodule D do
  @input File.read!("../input_07.txt")
  @sample_input "123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i"

  @fun_map %{
    "AND"    => &Bitwise.band/2,
    "NOT"    => &Bitwise.bnot/1,
    "OR"     => &Bitwise.bor/2,
    "LSHIFT" => &Bitwise.bsl/2,
    "RSHIFT" => &Bitwise.bsr/2,
  }

  
  def parse([value, "->", dest], acc) do 
    Map.put(acc, dest, String.to_integer(value))
  end

  def parse([value, "AND", wire2, "->", dest], acc) when is_number(value) do 
    value = String.to_integer(value)
    wire2 = Map.get(acc, wire2)
    Map.put(acc, dest, Bitwise.band(value, wire2))
  end

  def parse([wire1, "AND", wire2, "->", dest], acc) do 
    wire1 = Map.get(acc, wire1)
    wire2 = Map.get(acc, wire2)
    Map.put(acc, dest, Bitwise.band(wire1, wire2))
  end
  
  def parse([wire1, "OR", wire2, "->", dest], acc) do 
    wire1 = Map.get(acc, wire1)
    wire2 = Map.get(acc, wire2)
    Map.put(acc, dest, Bitwise.bor(wire1, wire2))
  end

  def parse([wire1, "LSHIFT", value, "->", dest], acc) do 
    wire1 = Map.get(acc, wire1)
    value = String.to_integer(value)
    Map.put(acc, dest, Bitwise.bsl(wire1, value))
  end

  def parse([wire1, "RSHIFT", value, "->", dest], acc) do 
    wire1 = Map.get(acc, wire1)
    value = String.to_integer(value)
    Map.put(acc, dest, Bitwise.bsr(wire1, value))
  end

  def parse(["NOT", wire1, "->", dest], acc) do 
    wire1 = Map.get(acc, wire1)
    Map.put(acc, dest, Bitwise.bnot(wire1))
  end


  def solve(instructions), do: solve(instructions, %{}, [])
  def solve([], table, []), do: table # |> Map.get("a")
  def solve([], table, instructions), do: solve(instructions, table, [])
  
  # Handles ["1600", "->", "u"]
  # Handles ["lx", "->", "u"]
  def solve([i = [n, _, dest] | rest], table, instructions) do
    case Integer.parse(n) do
      {n, _} -> solve(rest, Map.put(table, dest, n), instructions)
      :error -> 
        case Map.has_key?(table, n) do
          true -> 
            n = Map.get(table, n)
            solve(rest, Map.put(table, dest, n), instructions)
          false -> solve(rest, table, [i | instructions])
        end
    end
  end

  # Handles ["NOT", "lo", "->", "ed"] 
  def solve([i = [_, wire, _, dest] | rest], table, instructions) do
    case Map.has_key?(table, wire) do
      true -> 
        n = Map.get(table, wire)
        n = Bitwise.bnot(n)
        solve(rest, Map.put(table, dest, n), instructions)
      false -> solve(rest, table, [i | instructions])
    end
  end

  # Handles ["lf", "RSHIFT", "1", "->", "bo"]
  # Handles ["cj", "LSHIFT", "2", "->", "ga"]
  # Handles ["hb", "OR", "ab", "->", "ci"]
  # Handles ["km", "AND", "ij", "->", "hv"]
  # Handles ["1", "AND", "il", "->", "ag"]
  def solve([i = [n, op, v, _, dest] | rest], table, instructions) do
    case Integer.parse(n) do
      # Handles 5
      {n, _} -> 
        case Map.has_key?(table, v) do
          true -> 
            v = Map.get(table, v)
            n = Bitwise.band(n, v)
            solve(rest, Map.put(table, dest, n), instructions)
          false -> solve(rest, table, [i | instructions])
        end
      :error -> 
        case Integer.parse(v) do
          {v, _ } -> 
            case Map.has_key?(table, n) do
              true ->
                # Handles 1 and 2
                n = Map.get(table, n)
                val = @fun_map[op].(n, v)
                solve(rest, Map.put(table, dest, val), instructions)
              false -> solve(rest, table, [i | instructions])
            end
          :error ->
            # Handles 3 and 4
            case has_keys?(table, [n, v]) do
              true -> 
                [n, v] = get_values(table, [n, v])
                val = @fun_map[op].(n, v)
                solve(rest, Map.put(table, dest, val), instructions)
              false -> solve(rest, table, [i | instructions])
            end
        end
    end
  end

  def has_keys?(m, keys) do
    Enum.map(keys, fn key -> 
      Map.has_key?(m, key)
    end)
    |> Enum.all?()
  end

  def get_values(m, keys) do
    Enum.map(keys, fn key ->
      Map.get(m, key)
    end)
  end


  def parse_input() do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
  end

  # Try to solve
  # Solved when no more instructions
  # input = instructions
  # if can do instruction: do it, and next
  # else put back into insctruction and try next

  def t1 do
    parse_input()
    |> IO.inspect()
    |> solve()
    |> Map.get("a")
  end

  def t2 do
    parse_input()
    |> solve()
    |> Map.get("a")
    
  end  
end
