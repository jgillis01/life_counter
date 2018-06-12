defmodule LifeCounterServerTest do
  use ExUnit.Case, async: true

  alias LifeCounter.Player
  alias LifeCounter.Player.Counter

  setup do
    Registry.register(LifeCounter.Notifier, "player_adjusted", [])
    Registry.register(LifeCounter.Notifier, "player_reset", [])
    name = "Jerry-#{string_time()}"
    %{name: random_name, pid: pid} = Player.new(name, 30)
    {:ok, name: random_name, pid: pid}
  end

  test "it reports the total life count", %{name: name, pid: _pid} do
    assert Player.summary(name) == %{name: name, points: 30}
  end

  test "it reports the adjusted life count", %{name: name, pid: _pid} do
    Player.adjust(name, -10)
    assert_receive {:player_adjusted, %Counter{name: name}}
    assert Player.summary(name) == %{name: name, points: 20}
  end

  test "it resets the life count", %{name: name, pid: _pid} do
    Player.adjust(name, -15)
    assert_receive {:player_adjusted, %Counter{name: name}}
    assert Player.summary(name) == %{name: name, points: 15}
    Player.adjust(name, -5)
    assert_receive {:player_adjusted, %Counter{name: name}}
    assert Player.summary(name) == %{name: name, points: 10}
    Player.reset(name)
    assert_receive {:player_reset, %Counter{name: name}}
    assert Player.summary(name) == %{name: name, points: 30}
  end

  defp string_time() do
    DateTime.utc_now() |> DateTime.to_string()
  end
end
