defmodule Test.Domain.Clans.Create do
  alias Test.Repositories.Clans.Colonels
  alias Test.Repositories.Clans

  def call(tag, player) do
    with {:ok, clan} = right <- Clans.create(%{tag: tag}),
         {:ok, _} <- Colonels.create(%{clan_id: clan.id, player_id: player.id}) do
      right
    else
      error -> error
    end
  end
end
