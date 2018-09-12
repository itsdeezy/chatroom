defmodule Chatroom.RoomTest do
  use ExUnit.Case, async: true
  alias Chatroom.Room

  @a_room "room"

  setup do
    {:ok, room} = Room.start_link(@a_room)
    %{room: room}
  end

  test "can lookup room by name", %{room: room} do
    {:ok, ^room} = Room.lookup(@a_room)
  end
end