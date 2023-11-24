defmodule D do
  @input File.read!("../input_02.txt")
  @draw 3
  @win 6
  @loss 0
  @rock 1
  @paper 2
  @scissor 3

  # A and X = Rock
  # B and Y = Paper
  # C and Z = Scissor

  def play("A", "A"), do: @rock + @draw
  def play("A", "B"), do: @paper + @win
  def play("A", "C"), do: @scissor + @loss

  def play("B", "A"), do: @rock + @loss
  def play("B", "B"), do: @paper + @draw
  def play("B", "C"), do: @scissor + @win

  def play("C", "A"), do: @rock + @win
  def play("C", "B"), do: @paper + @loss
  def play("C", "C"), do: @scissor + @draw
  
  def convert_to_abc("X"), do: "A"
  def convert_to_abc("Y"), do: "B"
  def convert_to_abc("Z"), do: "C"

  def t1 do
    @input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc -> 
      [p1, p2] = String.split(line, " ", trim: true)
      p2 = convert_to_abc(p2)
      acc + play(p1, p2)
    end)
  end


  # X now means lose
  # Y now means draw
  # Z now means win

  def conv("A", "X"), do: "C"
  def conv("A", "Y"), do: "A"
  def conv("A", "Z"), do: "B"
  
  def conv("B", "X"), do: "A"
  def conv("B", "Y"), do: "B"
  def conv("B", "Z"), do: "C"

  def conv("C", "X"), do: "B"
  def conv("C", "Y"), do: "C"
  def conv("C", "Z"), do: "A"

  def t2 do
    @input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc -> 
      [p1, p2] = String.split(line, " ", trim: true)
      p2 = conv(p1, p2)
      acc + play(p1, p2)
    end)
  end

end
