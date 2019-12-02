defmodule Test do
  use Application

  def start(_type, _args) do
    Test.Supervisor.start_link([])
  end
end
