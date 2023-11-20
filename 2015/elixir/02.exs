defmodule DayTwo do
  @input File.read!("../input_02.txt")

  # Helpers:

  def line_to_numbers(line)  do
    line
    |> String.split("x", trim: :true)
    |> Enum.map(&(String.to_integer(&1)))
    |> Enum.sort()
  end

  def input_formatted do
    @input
    |> String.split("\n", trim: :true)
    |> Enum.map(&line_to_numbers(&1))
  end

  ## Task 1
  def t1 do
    input_formatted()
    |> Enum.map(fn [l, w, h] -> area(l, w, h) end)
    |> Enum.sum()
  end


  def area(l, w, h) do
    area = 2*l*w + 2*w*h + 2*h*l
    # Need extra paper. Works since sorted.
    extra_paper = l*w
    area + extra_paper
  end

  ## Task 2
  def t2 do
    input_formatted()
    |> Enum.map(fn [l, w, h] -> ribbon_area(l, w, h) end)
    |> Enum.sum()
  end

  def ribbon_area(l, w, h) do
    area = l + l + w + w
    extra_ribbon = l * w * h
    area + extra_ribbon
  end
 
end
