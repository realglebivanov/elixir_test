defmodule Test.Repositories.Invites do
  alias Test.Repositories.Invites

  use Test.Repositories.Repository, Test.Models.Invite

  def find_for_clan_and_player(clan, player) do
    Invites.find_by(fn invite -> invite.clan_id == clan.id && invite.player_id == player.id end)
  end
end
