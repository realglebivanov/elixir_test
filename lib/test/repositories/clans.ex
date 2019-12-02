defmodule Test.Repositories.Clans do
  alias Test.Repositories.Clans.{Colonels, Privates}

  use Test.Repositories.Repository, Test.Models.Clan

  def find_colonel(clan, player) do
    Colonels.find_by(fn colonel ->
      colonel.player_id == player.id && colonel.clan_id == clan.id
    end)
  end

  def find_private(clan, player) do
    Privates.find_by(fn private ->
      private.player_id == player.id && private.clan_id == clan.id
    end)
  end
end
