defmodule CounterTest do
  use ExUnit.Case
  doctest LifeCounter.Player.Counter

  alias LifeCounter.Player.Counter

  test "it sets a player name" do
    counter = Counter.new("JimBob", 30)
    assert counter.name == "JimBob"
  end

  test "it tracks the player starting points" do
    counter = Counter.new("JimBob", 30)
    assert counter.starting_points == 30
  end

  test "it tracks the total points for a player" do
    counter = Counter.new("JimBob", 30)
    counter = Counter.adjust(counter, -3)
    counter = Counter.adjust(counter, 1)
    summary = Counter.summary(counter)
    assert summary.points == 28
  end
end
