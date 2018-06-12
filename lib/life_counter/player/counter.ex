defmodule LifeCounter.Player.Counter do
  defstruct name: "", starting_points: 0, adjustments: []

  alias __MODULE__

  def new(name, points) do
    %Counter{name: name, starting_points: points}
  end

  def adjust(%Counter{} = counter, adjustment) do
    %{counter | adjustments: [adjustment | counter.adjustments]}
  end

  def summary(%Counter{} = counter) do
    points =
      counter.adjustments
      |> Enum.reverse()
      |> Enum.reduce(counter.starting_points, &(&2 + &1))

    %{name: counter.name, points: points}
  end
end
