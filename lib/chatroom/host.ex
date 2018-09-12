defmodule Chatroom.Host do
  @moduledoc """
  A host is a singleton under a chatroom supervisor. The host is
  responsible for broadcasting and maintaining the message log of
  its chatroom
  """

  use GenServer

  @proc_key __MODULE__

  def lookup(name) do
    Gproc.lookup({@proc_key, name})
  end

  ## Callbacks

  def child_spec(name) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [name]}
    }
  end

  def start_link(name) do
    # IO.puts "Starting new Chatroom.Host - named #{name}"
    GenServer.start_link(__MODULE__, nil, name: via_tuple(name))
  end

  def init(_opts) do
    {:ok, [initial_message()]}
  end

  ## Helpers

  def via_tuple(name) do
    Gproc.via_tuple({@proc_key, name})
  end

  defp initial_message do
    {:room, "Welcome!", DateTime.utc_now()}
  end
end