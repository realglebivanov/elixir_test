defmodule Test.Domain.Clans.KickTest do
  alias Test.Domain.Clans.Kick
  alias Test.Repositories.{Clans, Players}
  alias Test.Repositories.Clans.{Colonels, Privates}

  use ExUnit.Case

  test "kicks a private from clan if action is performed by a colonel" do
    assert {:ok, clan} = Clans.create(%{tag: "clan"})
    assert {:ok, player_colonel} = Players.create(%{login: "colonel"})
    assert {:ok, player_private} = Players.create(%{login: "private"})
    assert {:ok, colonel} = Colonels.create(%{player_id: player_colonel.id, clan_id: clan.id})
    assert {:ok, private} = Privates.create(%{player_id: player_private.id, clan_id: clan.id})
    assert :ok = Kick.call(clan, player_colonel, player_private)
  end

  test "doesnt kick a private from clan if action is performed not by a colonel" do
    assert {:ok, clan} = Clans.create(%{tag: "clan"})
    assert {:ok, player_colonel} = Players.create(%{login: "colonel"})
    assert {:ok, player_private} = Players.create(%{login: "private"})
    assert {:ok, colonel} = Colonels.create(%{player_id: player_colonel.id, clan_id: clan.id})
    assert {:ok, private} = Privates.create(%{player_id: player_private.id, clan_id: clan.id})
    assert {:error, _} = Kick.call(clan, player_private, player_private)
  end
end
