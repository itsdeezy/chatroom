defmodule Chatroom.Room do
  @moduledoc """
  A chatroom room process. This process contains information for the room
  supervisor. It's responsible for broadcasting messages from a single user
  process to all other user processes connected to this room's room. One room
  must be present per room.

  The room state contains a list of user pids and maintains a log stack of all
  messages that were sent by users in this room.

  Rooms are ran by the server.
  """

  use Supervisor

  @proc_key __MODULE__

  def lookup(name) do
    Gproc.lookup({@proc_key, name})
  end

  ## Callbacks

  def child_spec(name) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [name]},
      restart: :temporary,
      type: :worker,
    }
  end

  def start_link(name) do
    # IO.puts "Starting new Chatroom.Room - named #{name}"
    Supervisor.start_link(__MODULE__, name, name: via_tuple(name))
  end

  def init(name) do
    Supervisor.init([{Chatroom.Host, name}], strategy: :one_for_one)
  end

  defp via_tuple(name) do
    Gproc.via_tuple({@proc_key, name})
  end
end