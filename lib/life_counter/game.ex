defmodule LifeCounter.Game do
  alias LifeCounter.Game.Server

  @doc ~S"""
    Adds a player to the game
  """
  def add_player(player) do
    GenServer.cast(Server, {:add_player, player})
  end

  @doc ~S"""
    Retrieves the summary of the game.
  """
  def summary() do
    GenServer.call(Server, :summary)
  end

  @doc ~S"""
    Returns the number of players in the game.
  """
  def player_count() do
    GenServer.call(Server, :player_count)
  end
end
