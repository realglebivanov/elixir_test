defmodule Test.Supervisor do
  alias Test.Repositories.{Clans, Invites, Players}

  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      {Players, []},
      {Invites, []},
      {Clans, []},
      {Clans.Colonels, []},
      {Clans.Privates, []},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
