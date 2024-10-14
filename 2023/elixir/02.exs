defmodule D do
  @input File.read!("../input_02.txt")
  @max_red 12
  @max_green 13
  @max_blue 14
  @split_pattern ["Game ", ":", " ", ";", ","]
  

  def parse do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, @split_pattern, trim: true))
  end


  def is_legal_amount?([n, "red"]),   do: String.to_integer(n) <= @max_red
  def is_legal_amount?([n, "green"]), do: String.to_integer(n) <= @max_green
  def is_legal_amount?([n, "blue"]),  do: String.to_integer(n) <= @max_blue

  def run(list), do: run(list, [])
  def run([], acc), do: acc
  def run([_], _acc), do: false
  def run([n, color | rest], acc), do: run(rest, [is_legal_amount?([n, color]) | acc])


  def t1 do
    parse()
    |> Enum.reduce(0, fn line, acc -> 
      [id | rest] = line
      result = rest
        |> run()
        |> Enum.all?()

     # Map.put(acc, id, result)
      if result == true do
        acc + String.to_integer(id)
      else
        acc + 0
      end
    end)
  end


  def work(list), do: work(list, %{})
  def work([], acc), do: acc
  def work([n, color | rest], acc) do
    n = String.to_integer(n)
    case acc[color] do
      nil -> work(rest, Map.put(acc, color, n))
      v ->  
        case v < n do
          true -> work(rest, Map.put(acc, color, n))
          false -> work(rest, acc)
        end
    end
  end

  def t2 do
    parse()
    |> Enum.reduce(0, fn line, acc -> 
      [_id | rest] = line
      result = rest
        |> work()

      red = Map.get(result, "red")
      green = Map.get(result, "green")
      blue = Map.get(result, "blue")
      acc + red * green * blue
    end)
  end
  
end
