defmodule LifeCounter.Counter do
  defstruct player: "", starting_points: 0, adjustments: []

  alias __MODULE__

  def new(player, points) do
    %Counter{player: player, starting_points: points}
  end

  def adjust(%Counter{} = counter, adjustment) do
    %{counter | adjustments: [adjustment | counter.adjustments]}
  end

  def total(%Counter{} = counter) do
    counter.adjustments
    |> Enum.reverse()
    |> Enum.reduce(counter.starting_points, &(&2 + &1))
  end
end
