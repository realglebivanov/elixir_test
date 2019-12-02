defmodule Test.Domain.Invites.Decline do
  alias Test.Repositories.Invites

  def call(invite) do
    new_invite = %{invite | status: :declined}
    Invites.save(new_invite)
    {:ok, %{invite: new_invite}}
  end
end
