defmodule LifeCounterServerTest do
  use ExUnit.Case, async: true

  alias LifeCounter.Server

  setup do
    {:ok, jerry} = GenServer.start_link(Server, {"Jerry", 30})
    {:ok, jerry: jerry}
  end

  test "it reports the total life count", %{jerry: jerry} do
    assert GenServer.call(jerry, :total) == 30
  end

  test "it reports the adjusted life count", %{jerry: jerry} do
    GenServer.cast(jerry, {:adjust, -10})
    assert GenServer.call(jerry, :total) == 20
  end

  test "it resets the life count", %{jerry: jerry} do
    GenServer.cast(jerry, {:adjust, -15})
    assert GenServer.call(jerry, :total) == 15
    GenServer.cast(jerry, {:adjust, -5})
    assert GenServer.call(jerry, :total) == 10
    GenServer.cast(jerry, :reset)
    assert GenServer.call(jerry, :total) == 30
  end
end
