defmodule D do
  @input File.read!("../input_01.txt")
  @regex_decimals ~r/\d/
  @regex_all_numbers ~r/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/
  @sample_input "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"


  def t1 do
    @input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc -> 
      nums = Regex.scan(@regex_decimals, line)
          |> List.flatten
      [a] = Enum.take(nums, 1)
      [b] = Enum.take(nums, -1)

      val = a <> b 
        |> String.to_integer()

      val + acc
    end)
  end


  #def str_to_num("zero"),  do: "0"
  def str_to_num("one"),   do: "1"
  def str_to_num("two"),   do: "2"
  def str_to_num("three"), do: "3"
  def str_to_num("four"),  do: "4"
  def str_to_num("five"),  do: "5"
  def str_to_num("six"),   do: "6"
  def str_to_num("seven"), do: "7"
  def str_to_num("eight"), do: "8"
  def str_to_num("nine"),  do: "9"
  def str_to_num(n),       do: n

  def t2 do
    @input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc -> 
      nums = Regex.scan(@regex_all_numbers, line)
          |> List.flatten
          |> Enum.filter(& &1 != "")
      [a] = Enum.take(nums, 1)
      [b] = Enum.take(nums, -1)
      IO.inspect nums
      IO.inspect(a)
      IO.inspect(b)
      a = a |> str_to_num()
      b = b |> str_to_num()

      val = a <> b 
        |> String.to_integer()

      IO.inspect val
      IO.puts "___________"

      val + acc
    end)
  end
  
  
end
