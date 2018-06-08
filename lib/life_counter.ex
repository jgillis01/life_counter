defmodule LifeCounter do
  def add_player(player, starting_points) do
    player = new_player(player, starting_points)
    LifeCounter.Game.add_player(player)
    player.name
  end

  defdelegate remove_player(player_name), to: LifeCounter.Game
  defdelegate game_summary(), to: LifeCounter.Game, as: :summary
  defdelegate adjust_player(player_name, adjustment), to: LifeCounter.Player, as: :adjust
  defdelegate reset_player(player_name), to: LifeCounter.Player, as: :reset
  defdelegate new_player(player, starting_points), to: LifeCounter.Player, as: :new
end
