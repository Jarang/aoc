defmodule D do
  @input File.read!("../input_07.txt")
  @fun_map %{
    "AND"    => &Bitwise.band/2,
    "NOT"    => &Bitwise.bnot/1,
    "OR"     => &Bitwise.bor/2,
    "LSHIFT" => &Bitwise.bsl/2,
    "RSHIFT" => &Bitwise.bsr/2,
  }

  def solve(instructions), do: solve(instructions, %{}, [])
  def solve([], table, []), do: table
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
  def solve([i = [op, wire, _, dest] | rest], table, instructions) do
    case Map.has_key?(table, wire) do
      true -> 
        n = Map.get(table, wire)
        result = @fun_map[op].(n)
        solve(rest, Map.put(table, dest, result), instructions)
      false -> solve(rest, table, [i | instructions])
    end
  end

  # Handles ["lf", "RSHIFT", "1", "->", "bo"]
  # Handles ["cj", "LSHIFT", "2", "->", "ga"]
  # Handles ["hb", "OR", "ab", "->", "ci"]
  # Handles ["km", "AND", "ij", "->", "hv"]
  # Handles ["1", "AND", "il", "->", "ag"]
  def solve([i = [n, op, v, _, dest] | rest], table, instructions) do
    [n, v] = to_int_or_key(n, v)
    case has_keys?(table, [n, v]) do
      true -> 
        [n, v] = get_values(table, [n, v])
        result = @fun_map[op].(n, v)
        solve(rest, Map.put(table, dest, result), instructions)
      false -> solve(rest, table, [i | instructions])
      end
  end

  def has_keys?(m, keys) do
    Enum.all?(keys, fn key -> (Map.has_key?(m, key) || is_integer(key))  end)
  end

  def get_values(m, keys) do
    Enum.map(keys, fn key -> if is_binary(key), do: Map.get(m, key), else: key end)
  end

  def to_int_or_key(n, v) do
    case {Integer.parse(n), Integer.parse(v)} do
      {{i, _}, {j, _}} -> [i, j]
      {{i, _}, :error} -> [i, v]
      {:error, {j, _}} -> [n, j]
      {:error, :error} -> [n, v]
    end
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
  # else put back into instruction and try next

  def t1 do
    parse_input()
    |> solve()
    |> Map.get("a")
  end

  def t2 do
    res = t1() |> Integer.to_string()
    override_cmd = [[res, "->", "b"]]
    
    parse_input() ++ override_cmd
    |> solve()
    |> Map.get("a")
  end  
end
