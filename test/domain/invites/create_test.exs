defmodule Test.Domain.Invites.CreateTest do
  alias Test.Models.{Invite, Player, Clan}
  alias Test.Domain.Invites.Create
  alias Test.Repositories.{Players, Clans}
  use ExUnit.Case

  test "creates an invite with given clan and player" do
    {:ok, player} = Players.create(%{login: "!!!BLACKOVERLORD!!!"})
    {:ok, clan} = Clans.create(%{tag: "PWNAGE777"})
    assert {:ok, invite} = Create.call(clan, player)
  end

  test "doesnt create an invite if given player has already been invited" do
    {:ok, %Player{} = player} = Players.create(%{login: "!!!BLACKOVERLORD!!!"})
    {:ok, %Clan{} = clan} = Clans.create(%{tag: "PWNAGE777"})
    assert {:ok, %Invite{} = invite} = Create.call(clan, player)
    assert {:error, :cannot_invite_player_twice} = Create.call(clan, player)
  end
end
