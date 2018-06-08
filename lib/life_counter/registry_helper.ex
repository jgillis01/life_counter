defmodule LifeCounter.RegistryHelper do
  def notify(channel, payload) do
    Registry.dispatch(LifeCounter.Notifier, channel, fn entries ->
      for {pid, _} <- entries, do: send(pid, {String.to_atom(channel), payload})
    end)
  end
end
