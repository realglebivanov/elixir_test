defmodule Test.Domain.Invites.DeclineTest do
  alias Test.Domain.Invites.Decline
  alias Test.Repositories.{Players, Clans, Invites}
  use ExUnit.Case

  test "accepts an invite" do
    {:ok, player} = Players.create(%{login: "YOUMUSTBEKIDDING"})
    {:ok, clan} = Clans.create(%{tag: "M3NA"})
    {:ok, invite} = Invites.create(%{clan_id: clan.id, player_id: player.id})
    assert {:ok, %{invite: new_invite}} = Decline.call(invite)
    assert new_invite.status == :declined
  end
end
