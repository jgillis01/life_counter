defmodule LifeCounter.App do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: LifeCounter.PlayerRegistry}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
