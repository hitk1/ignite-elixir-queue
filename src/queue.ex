defmodule Queue do
  use GenServer

  require Logger

  #Cliet
  def start_link(_state) do
    GenServer.start_link(__MODULE__, [1, 2, 3])
  end

  def dequeue(pid) do
    GenServer.call(pid, :pop)
  end

  #Server

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do

    {:reply, head, tail}
  end
end
