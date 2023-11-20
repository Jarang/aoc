defmodule DayOne do
  @input File.read!("../input_01.txt") |> String.trim()

  ###### Task 1
  def t1 do
    total_floor()
  end

  def total_floor do
    @input
    |> String.split("", trim: :true)
    |> Enum.map(fn letter -> tonumber(letter) end)
    |> Enum.sum()
    |> IO.puts
  end


  ###### Task 2
  def t2 do
    first_basement()
  end

  def first_basement() do
     # Returns index when acc is 0, index starts at 1.
      @input
      |> String.split("", trim: :true)
      |> Enum.map(fn letter -> tonumber(letter) end)
      |> Enum.reduce_while({1,0}, fn (val, {index, acc}) ->
          if acc == 0 and index !== 1 , do: {:halt, index}, else: {:cont, {index+1, acc + val}}
        end)
      |> IO.puts
  end

  ###### Helpers
  def tonumber(val) do
    case val do
       "(" -> 1
       ")" -> -1
       _ -> 0
    end
  end

end
