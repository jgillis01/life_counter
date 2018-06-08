defmodule LifeCounter.App do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: LifeCounter.PlayerRegistry},
      {Registry, keys: :duplicate, name: LifeCounter.Notifier},
      {LifeCounter.Game.Server, :ok}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
