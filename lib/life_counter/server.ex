defmodule LifeCounter.Server do
  use GenServer

  alias LifeCounter.Counter

  def init({player, starting_points}) do
    {:ok, Counter.new(player, starting_points)}
  end

  def handle_call(:total, _from, counter) do
    {:reply, Counter.total(counter), counter}
  end

  def handle_cast({:adjust, adjustment}, counter) do
    {:noreply, Counter.adjust(counter, adjustment)}
  end

  def handle_cast(:reset, counter) do
    {:noreply, %{counter | adjustments: []}}
  end
end
