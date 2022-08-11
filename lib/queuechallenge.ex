defmodule Queue do
  use GenServer

  require Logger

  # Cliet
  def start_link(_state) do
    GenServer.start_link(__MODULE__, [1, 2, 3])
  end

  def dequeue(pid) do
    GenServer.call(pid, :pop)
  end

  def enqueue(pid, value) do
    GenServer.cast(pid, {:insert, value})
  end

  def get_queue(pid) do
    GenServer.call(pid, :get_queue)
  end

  # Server

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:get_queue, _from, state), do: {:reply, state, state}

  @impl true
  def handle_cast({:insert, value}, state) do
    reversed = Enum.reverse(state)
    new_state = [value | reversed]
    {:noreply, Enum.reverse(new_state)}
  end
end
