defmodule Test.Domain.Clans.JoinTest do
  alias Test.Domain.Players.Join
  use ExUnit.Case

  test "creates a player with given login" do
    login = "VASYAN666"
    assert {:ok, player} = Join.call(login)
    assert player.login == login
  end
end
