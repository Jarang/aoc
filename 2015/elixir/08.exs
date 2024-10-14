defmodule D do
  @input File.read!("../input_08.txt")

  def parse() do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> IO.inspect()
  end

  def parse2() do
    @input
    |> String.split("\n", trim: true)
  end

  
  def run(list), do: run(list, 0)
  def run([], acc), do: acc
  def run(["\\", "x", a, b  | rest], acc), do: run(rest, acc + 6  - 1)
  def run(["\\", "\"" | rest], acc), do: run(rest, acc + 2 - 1)
  def run(["\\" | rest], acc), do: run(rest, acc + 2 - 1)
  def run(["\"" | rest], acc), do: run(rest, acc + 1 - 0)
  def run([_ | rest], acc), do: run(rest, acc + 1 - 0)

  def t1 do
    parse()
    |> run()
  end

  def t0 do
    
  end


  
end
