defmodule DayFive do
  @input File.read!("../input_05.txt")
  @vowels "aeiou"
  @min_vowels 3
  @illegals ["ab", "cd", "pq", "xy"]


  # Helpers
  
  # Count vowels
  def count_vowels(s) do
    s
    |> String.split("", trim: true)
    |> Enum.reduce(0, fn letter, acc -> 
        case String.contains?(@vowels, letter) do
          true -> acc + 1
          false -> acc 
        end
      end)
  end

  # A letter appears twice in a row
  def has_double_letters(word) when is_binary(word), do: String.split(word, "", trim: true) |> has_double_letters()

  def has_double_letters([]), do: false
  def has_double_letters([_]), do: false
  def has_double_letters([same, same | _rest]), do: true
  def has_double_letters([_ | rest]), do: has_double_letters(rest)
  def has_double_letters(_), do: false

  # Doesn't contain illegal words
  def illegal_words(s, illegal \\ @illegals) do
    String.contains?(s, illegal) 
  end

  def word_is_nice(word) do
    double_letter = has_double_letters(word)
    no_illegal_word = illegal_words(word) |> Kernel.!
    enough_vowels = count_vowels(word) >= @min_vowels

    double_letter && no_illegal_word && enough_vowels
  end

  # Task1
  def t1 do
    @input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn word, acc -> 
      if word_is_nice(word) do
        acc + 1
      else
        acc
      end
    end)
  end

  # Task2
  
  def has_repeat_with_wildcard(word) when is_binary(word), do: String.split(word, "", trim: true) |> has_repeat_with_wildcard()

  def has_repeat_with_wildcard([]), do: false
  def has_repeat_with_wildcard([_]), do: false
  def has_repeat_with_wildcard([same, _, same | _rest]), do: true
  def has_repeat_with_wildcard([_head | tail]), do: has_repeat_with_wildcard(tail)
  def has_repeat_with_wildcard(_), do: false

  # TODO: this almost works.
  def has_repeat_pair_without_overlap(word) when is_binary(word), do: String.split(word, "", trim: true) |> has_repeat_pair_without_overlap([])
  def has_repeat_pair_without_overlap([], _), do: false
  def has_repeat_pair_without_overlap([_], _), do: false
  def has_repeat_pair_without_overlap([_head | tail], _) when length(tail) < 3, do: false
  def has_repeat_pair_without_overlap([a, b | _tail], [a,b]), do: true
  def has_repeat_pair_without_overlap([a, b | tail], [_, _]), do: has_repeat_pair_without_overlap([b | tail], [a, b])
  def has_repeat_pair_without_overlap([a, b | tail], _), do: has_repeat_pair_without_overlap([b | tail], [a, b])
  def has_repeat_pair_without_overlap(_, _), do: false

  
  # This works, repeat pair without overlap
  def g(word) when is_binary(word), do: String.split(word, "", trim: true) |> g()
  def g([]), do: false
  def g([_]), do: false
  def g([a, b | rest]) do
    first_two = Enum.join([a, b])
    last = Enum.join(rest)
    
    l = String.contains?(last, first_two)
    if l do
      true
    else
      g([b | rest])
    end
  end

  def t2 do
    @input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn word, acc -> 
        if has_repeat_with_wildcard(word) and g(word) do
          acc + 1
        else
          acc
        end
      end)
  end
end
