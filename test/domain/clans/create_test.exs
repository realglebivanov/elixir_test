defmodule Test.Domain.Clans.CreateTest do
  alias Test.Domain.Clans.Create
  alias Test.Repositories.Players
  use ExUnit.Case

  test "creates a clan with given tag and player" do
    tag = "PWNAGE777"
    {:ok, player} = Players.create(%{login: "YOUMUSTBEKIDDING"})
    assert {:ok, clan} = Create.call(tag, player)
    assert clan.tag == tag
  end
end
