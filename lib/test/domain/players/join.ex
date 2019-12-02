defmodule Test.Domain.Players.Join do
  alias Test.Repositories.Players

  def call(login), do: Players.create(%{login: login})
end
