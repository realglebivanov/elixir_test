defmodule Test.Domain.Clans.Kick do
  alias Test.Repositories.Clans.Privates
  alias Test.Repositories.Clans

  def call(clan, kicker, player) do
    with {:ok, private} <- Clans.find_private(clan, player),
         {:ok, _} <- Clans.find_colonel(clan, kicker),
         :ok <- Privates.delete(private.id) do
      :ok
    else
      error -> error
    end
  end
end
