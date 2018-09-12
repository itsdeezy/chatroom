defmodule Chatroom.LobbyTest do
  @moduledoc """
  NOTE!
  This suite of tests deal with the Chatroom.Lobby genserver, which
  is started in the :chtroom application supervision tree. Your test
  should start with the restarting of the app to ensure no bleeding of
  states between tests.
  """
  use ExUnit.Case, async: true
  alias Chatroom.Lobby

  @a_room "room"
  @another_room "another_room"

  setup do
    Application.stop(:chatroom)
    :ok = Application.start(:chatroom)
    {:ok, room} = Lobby.start_room(@a_room)
    %{room: room}
  end

  test "can count rooms" do
    assert 1 == Lobby.count_rooms()
  end

  test "can start a room" do
    assert {:ok, _} = Lobby.start_room(@another_room)
  end

  test "can stop a room", %{room: room} do
    ref = Process.monitor(room)
    assert Lobby.stop_room(@a_room)
    assert_receive {:DOWN, ^ref, _, _, _}
  end
end