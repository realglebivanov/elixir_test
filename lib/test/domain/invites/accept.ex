defmodule Test.Domain.Invites.Accept do
  alias Test.Repositories.{Clans, Invites, Players}
  alias Test.Repositories.Clans.Privates

  def call(invite) do
    with {:ok, clan} <- Clans.find(invite.clan_id),
         {:ok, player} <- Players.find(invite.player_id),
         {:ok, private} <- Privates.create(%{player_id: player.id, clan_id: clan.id}),
         new_invite <- %{invite | status: :accepted},
         :ok = Invites.save(new_invite) do
      {:ok, %{private: private, invite: new_invite}}
    else
      error -> error
    end
  end
end
