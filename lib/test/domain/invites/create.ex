defmodule Test.Domain.Invites.Create do
  alias Test.Repositories.Invites

  def call(clan, player) do
    with :ok <- not_invited(clan, player),
         {:ok, _} = right <- Invites.create(%{clan_id: clan.id, player_id: player.id}) do
      right
    else
      error -> error
    end
  end

  defp not_invited(clan, player) do
    case Invites.find_by(fn invite -> invite.clan_id == clan.id && invite.player_id == player.id end) do
      {:ok, _} -> {:error, :cannot_invite_player_twice}
      _ -> :ok
    end
  end
end
