defmodule LifeCounter.Player.Server do
  use GenServer

  alias LifeCounter.Player.Counter
  import LifeCounter.RegistryHelper, only: [notify: 2]

  def init({player_name, starting_points}) do
    {:ok, Counter.new(player_name, starting_points)}
  end

  def handle_call(:summary, _from, player) do
    {:reply, Counter.summary(player), player}
  end

  def handle_cast({:adjust, adjustment}, player) do
    player = Counter.adjust(player, adjustment)
    notify("player_adjusted", player)
    {:noreply, player}
  end

  def handle_cast(:reset, player) do
    player = %{player | adjustments: []}
    notify("player_reset", player)
    {:noreply, player}
  end
end
