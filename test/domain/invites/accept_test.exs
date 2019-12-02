defmodule Test.Domain.Invites.AcceptTest do
  alias Test.Domain.Invites.Accept
  alias Test.Repositories.{Players, Clans, Invites}
  use ExUnit.Case

  test "accepts an invite" do
    {:ok, player} = Players.create(%{login: "YOUMUSTBEKIDDING"})
    {:ok, clan} = Clans.create(%{tag: "M3NA"})
    {:ok, invite} = Invites.create(%{clan_id: clan.id, player_id: player.id})
    assert {:ok, %{private: private, invite: new_invite}} = Accept.call(invite)
    assert new_invite.status == :accepted
    assert private.player_id == player.id
  end
end
