defmodule LifeCounterGameTest do
  use ExUnit.Case, async: true

  alias LifeCounter.{Game, Player}

  setup do
    Registry.register(LifeCounter.Notifier, "player_joined", [])
    Registry.register(LifeCounter.Notifier, "player_left", [])
    player = Player.new("Jerry", 30)
    Game.add_player(player)
    {:ok, name: player.name, pid: player.pid}
  end

  test "it notifies when players are added", %{name: name, pid: pid} do
    refute Game.player_count() == 0
    assert_receive {:player_joined, %{name: ^name, pid: ^pid}}
  end

  test "it notifies when players leave the game", %{name: name, pid: pid} do
    Process.exit(pid, :kill)
    assert_receive {:player_left, %{name: ^name, pid: ^pid}}
  end

  test "it removes players from the game", %{name: name, pid: pid} do
    count = Game.player_count()
    Process.exit(pid, :kill)
    assert_receive {:player_left, %{name: ^name, pid: ^pid}}
    assert Game.player_count() == count - 1
  end
end
