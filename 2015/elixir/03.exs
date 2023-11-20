defmodule DayThree do
  @input File.read!("../input_03.txt") |> String.trim()

  # Helpers
  def split_input do
    @input
    |> String.split("", trim: true)
  end

  def symbol_to_map("v"), do: {-1, 0}
  def symbol_to_map("^"), do: {1, 0}
  def symbol_to_map(">"), do: {0, 1}
  def symbol_to_map("<"), do: {0, -1}

  ## Task 1
  def t1 do
    m = split_input() 
    |> Enum.reduce(%{:x => 0, :y => 0, :visited => MapSet.new([{0, 0}])}, fn input, acc ->
      {x, y}  = symbol_to_map(input)
      newX = x + acc[:x] 
      newY = y + acc[:y]
      newVisited = acc[:visited] |> MapSet.put({newX, newY})
      %{:x => newX, :y => newY, :visited => newVisited }
    end)
    
    m[:visited] |> Enum.count()
  end

  ## Task 2
  def t2 do
    m = split_input()
    |> Enum.reduce(%{:x => 0, :y => 0, :x2 => 0, :y2 => 0, :santas_turn => true,  :visited => MapSet.new([{0, 0}])}, fn input, acc ->
      {x, y}  = symbol_to_map(input)
      
      {newX, newY, newX2, newY2, newVisited} = if acc[:santas_turn] do
        newX = x + acc[:x]
        newY = y + acc[:y]
        newVisited = acc[:visited] |> MapSet.put({newX, newY})
        {newX, newY, acc[:x2], acc[:y2], newVisited}
      else 
        newX2 = x + acc[:x2]
        newY2 = y + acc[:y2]
        newVisited = acc[:visited] |> MapSet.put({newX2, newY2})
        {acc[:x], acc[:y], newX2, newY2, newVisited}
      end
 
      %{:x => newX, :y => newY, :x2 => newX2, :y2 => newY2, :santas_turn => acc[:santas_turn] |> Kernel.!,  :visited => newVisited }
    end)
    
    m[:visited] |> Enum.count()
  end
end
