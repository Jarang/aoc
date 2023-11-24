defmodule D do
  @input File.read!("../input_01.txt")

  def t1 do
    {max_calories_for_one_elf, _index} =
      @input 
      |> String.split("\n")
      |> Enum.reduce(%{:i => 0}, fn cal, acc -> 
        if cal == "" do
          %{acc | :i => acc[:i] + 1}
        else
          prev = Map.get(acc, acc[:i], 0)
          Map.put(acc, acc[:i], prev + String.to_integer(cal))
        end
      end)
      |> Map.values()
      |> Enum.with_index()
      |> Enum.max()
  end
  
  def t2 do
    [top1, top2, top3 | _rest] =
      @input 
      |> String.split("\n")
      |> Enum.reduce(%{:i => 0}, fn cal, acc -> 
        if cal == "" do
          %{acc | :i => acc[:i] + 1}
        else
          prev = Map.get(acc, acc[:i], 0)
          Map.put(acc, acc[:i], prev + String.to_integer(cal))
        end
      end)
      |> Map.values()
      |> Enum.sort()
      |> Enum.reverse()

      top1 + top2 + top3
  end

end

