defmodule DaySix do
  @input File.read!("../input_06.txt") 
         |> String.split("\n", trim: true)

  @split_pattern [" ", ","]



  def work({:toggle, {x, y}, {xx, yy}}, state, is_t2) do
    gen({x, y}, {xx, yy})
    |> Enum.reduce(state, fn (field, acc) -> 
      new_state = toggle(acc, field, is_t2)
      new_state
    end)
  end

  def work({:off, {x, y}, {xx, yy}}, state, is_t2) do
    gen({x, y}, {xx, yy})
    |> Enum.reduce(state, fn (field, acc) -> 
      new_state = off(acc, field, is_t2)
      new_state
    end)
  end

  def work({:on, {x, y}, {xx, yy}}, state, is_t2) do
    gen({x, y}, {xx, yy})
    |> Enum.reduce(state, fn (field, acc) -> 
      new_state = on(acc, field, is_t2)
      new_state
    end)
  end
  
  def parse(type, nums) do
    [x, y, xx, yy] = nums |> Enum.map(&String.to_integer/1)
    {type, {x, y}, {xx, yy}}
  end
  
  def parse(["toggle", x, y, _, xx, yy]) do
    parse(:toggle, [x, y, xx, yy])
  end

  def parse([_, "on", x, y, _, xx, yy]) do
    parse(:on, [x, y, xx, yy])
  end

  def parse([_, "off", x, y, _, xx, yy]) do
    parse(:off, [x, y, xx, yy])
  end

  def off(state, field, :is_t2) do 
    Map.update!(state, field, fn config -> 
      case config do
         0 -> 0
         n -> n - 1
      end
    end)
  end

  def off(state, field, _) do 
    Map.put(state, field, :off)
  end

  def on(state, field, :is_t2) do 
    Map.update!(state, field, fn config -> config + 1 end)
  end
  
  def on(state, field, _) do 
    Map.put(state, field, :on)
  end

  def toggle(state, field, :is_t2) do
    Map.update!(state, field, fn config -> config + 2 end)
  end

  def toggle(state, field, t) do
    config = Map.get(state, field)
    case config do
       :on -> off(state, field, t)
       :off -> on(state, field, t)
    end
  end

  def gen({x, y}, {xx, yy}) do
    for x <- x..xx, y <- y..yy, do: {x, y}
  end
  
  def init_state(value) do
    gen({0, 0}, {999, 999})
    |> Enum.reduce(%{}, fn (key, acc) -> Map.put(acc, key, value) end)
  end

  def t1 do
    state = init_state(:off)
    
    @input
    |> Stream.map(&String.split(&1, @split_pattern))
    |> Stream.map(&parse(&1))
    |> Enum.reduce(state, fn line, acc ->
      line
      |> work(acc, :is_t1)
        
    end)
    |> Enum.count(fn ({_k, config}) -> config == :on end) 
  end



  def t2 do
    state = init_state(0)
    
    @input
    |> Stream.map(&String.split(&1, @split_pattern))
    |> Stream.map(&parse(&1))
    |> Enum.reduce(state, fn line, acc ->
      line
      |> work(acc, :is_t2)
        
    end)
    |> Enum.reduce(0, fn ({_k, v}, acc) -> acc + v end) 
  end
  
  
end
