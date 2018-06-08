defmodule LifeCounter.Game.Server do
  use GenServer

  import LifeCounter.RegistryHelper, only: [notify: 2]

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_call(:summary, _from, players) do
    summary =
      players
      |> Enum.map(&GenServer.call(&1.pid, :summary))

    {:reply, summary, players}
  end

  def handle_call(:player_count, _from, players) do
    {:reply, length(players), players}
  end

  def handle_cast({:add_player, player}, players) do
    Process.monitor(player.pid)
    notify("player_joined", player)

    {:noreply, [player | players]}
  end

  def handle_cast({:remove_player, player}, players) do
    player =
      players
      |> Enum.filter(&(&1.name == player))
      |> List.first()

    Process.exit(player.pid, :kill)
    {:noreply, players}
  end

  def handle_info({:DOWN, _ref, :process, object, _reason}, players) do
    [player] = players |> Enum.filter(&(&1.pid == object))
    new_players = players |> Enum.reject(&(&1.pid == object))
    notify("player_left", player)

    {:noreply, new_players}
  end
end
