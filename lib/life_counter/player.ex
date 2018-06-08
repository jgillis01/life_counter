defmodule LifeCounter.Player do
  alias LifeCounter.Player.Server

  @doc ~S"""
    Creates a new player process using the given `player_name` and `starting_points`.
    It returns a map containing the randomized player `name` and process `pid`.
  """
  def new(player_name, starting_points) do
    random_name = player_name |> randomize_name()
    name = random_name |> name_via_registry()
    {:ok, pid} = GenServer.start(Server, {random_name, starting_points}, name: name)
    %{name: random_name, starting_points: starting_points, pid: pid}
  end

  @doc ~S"""
    Adjust the player identified by the `player_name` with the given `adjustment`
  """
  def adjust(player_name, adjustment) do
    name = player_name |> name_via_registry()
    GenServer.cast(name, {:adjust, adjustment})
  end

  @doc ~S"""
    Return a summary of the player identified by the given `player_name`
  """
  def summary(player_name) do
    name = player_name |> name_via_registry()
    GenServer.call(name, :summary)
  end

  @doc ~S"""
    Remove the adjustment for the given player identified by `player_name`.
  """
  def reset(player) do
    counter = name_via_registry(player)
    GenServer.cast(counter, :reset)
  end

  defp name_via_registry(name) do
    {:via, Registry, {LifeCounter.PlayerRegistry, name}}
  end

  defp randomize_name(name) do
    "#{name}-#{:rand.uniform(1000)}"
  end
end
