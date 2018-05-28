defmodule LifeCounter do
  alias LifeCounter.Server

  def new(player, starting_points) do
    name = {:via, Registry, {LifeCounter.PlayerRegistry, player}}
    GenServer.start_link(Server, {player, starting_points}, name: name)
  end

  def total(counter) do
    GenServer.call(counter, :total)
  end

  def adjust(counter, adjustment) do
    GenServer.cast(counter, {:adjust, adjustment})
  end

  def reset(counter) do
    GenServer.cast(counter, :reset)
  end
end
