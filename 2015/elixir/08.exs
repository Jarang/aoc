defmodule D do
  @input File.read!("../input_08.txt")

  def parse() do
    @input
    |> String.split("\n", trim: true)

    # |> Enum.map(&String.split(&1, "", trim: true))
    # |> IO.inspect()
  end

  def parse2() do
    @input
    |> String.split("\n", trim: true)
  end

  def calc_code(list), do: calc_code(list, 0)
  def calc_code([], acc), do: acc
  # \x03
  def calc_code(["\\", "x", _, _ | rest], acc), do: calc_code(rest, acc + 4)
  # \"
  def calc_code(["\\", "\"" | rest], acc), do: calc_code(rest, acc + 2)
  # \\
  def calc_code(["\\", "\\" | rest], acc), do: calc_code(rest, acc + 2)
  # " at the start and end of the line
  def calc_code(["\"" | rest], acc), do: calc_code(rest, acc + 1)
  # any other character
  def calc_code([_ | rest], acc), do: calc_code(rest, acc + 1)


  def calc_data(list), do: calc_data(list, 0)
  def calc_data([], acc), do: acc
  # \x03
  def calc_data(["\\", "x", _, _ | rest], acc), do: calc_data(rest, acc + 1)
  # \"
  def calc_data(["\\", "\"" | rest], acc), do: calc_data(rest, acc + 1)
  # \\
  def calc_data(["\\", "\\" | rest], acc), do: calc_data(rest, acc + 1)
  # " at the start and end of the line
  def calc_data(["\"" | rest], acc), do: calc_data(rest, acc + 0)
  # any other character
  def calc_data([_ | rest], acc), do: calc_data(rest, acc + 1)

  def t1 do
    parse()
    |> Enum.map(fn x ->
      code =
        x
        |> String.split("", trim: true)
        |> calc_code()

      data =
        x
        |> String.split("", trim: true)
        |> calc_data()
      # IO.inspect("#{x}; code: #{code} - data: #{data}")
      code - data
    end)
    |> Enum.sum()
  end


  def calc_new_code(list), do: calc_new_code(list, 0)
  def calc_new_code([], acc), do: acc
  # \x03
  def calc_new_code(["\\", "x", _, _ | rest], acc), do: calc_new_code(rest, acc + 5)
  # \"
  def calc_new_code(["\\", "\"" | rest], acc), do: calc_new_code(rest, acc + 4)
  # \\
  def calc_new_code(["\\", "\\" | rest], acc), do: calc_new_code(rest, acc + 4)
  # " at the start and end of the line
  def calc_new_code(["\"" | rest], acc), do: calc_new_code(rest, acc + 3)
  # any other character
  def calc_new_code([_ | rest], acc), do: calc_new_code(rest, acc + 1)

  def t2 do
    parse()
    |> Enum.map(fn x ->
      new_code =
        x
        |> String.split("", trim: true)
        |> calc_new_code()

      code =
        x
        |> String.split("", trim: true)
        |> calc_code()
      # IO.inspect("#{x}; new_code: #{new_code} - code: #{code}")
      new_code - code
    end)
    |> Enum.sum()
  end
end
