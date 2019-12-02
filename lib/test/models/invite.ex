defmodule Test.Models.Invite do
  @enforce_keys [:id, :clan_id, :player_id, :status]
  defstruct [:id, :clan_id, :player_id, status: :new]
end
