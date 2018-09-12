defmodule Chatroom.Lobby do
  @moduledoc """
  Lobby is a dynamic supervisor of all the room processes in this application
  """

  use DynamicSupervisor
  alias Chatroom.Room

  @proc __MODULE__

  ## Public Interface

  def start_room(name) do
    DynamicSupervisor.start_child(@proc, {Room, name})
  end

  def stop_room(name) do
    case Room.lookup(name) do
      # Not sure about killing it here
      {:ok, room} -> Process.exit(room, :kill)
      {:error, reason} -> reason
    end
  end

  def count_rooms do
    @proc
    |> DynamicSupervisor.which_children()
    |> length()
  end

  ## Callback
  def start_link do
    opts = [strategy: :one_for_one]
    DynamicSupervisor.start_link(__MODULE__, opts, name: @proc)
  end

  def init(opts) do
    DynamicSupervisor.init(opts)
  end
end