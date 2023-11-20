defmodule DayFour do
  @input File.read!("../input_04.txt") |> String.trim()

  # Helpers
  def hash(input) do
    :crypto.hash(:md5, input) |> Base.encode16(case: :lower)
  end

  def asd(n, win_condition) do
    m =
      (@input <> Integer.to_string(n))
      |> hash
      |> String.slice(0, String.length(win_condition))
      # IMAGINE FORGETTING TO SWITCH THE SLICE SIZE BETWEEN T1 and T2 LMAO

    if m === win_condition do
      n
    else
      asd(n + 1, win_condition)
    end
  end
  
  # Task1
  def t1 do
    asd(1, "00000")
  end

  # Task2
  def t2 do
    asd(1, "000000")
  end
end
