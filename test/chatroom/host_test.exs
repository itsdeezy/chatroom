defmodule Chatroom.HostTest do
  use ExUnit.Case, async: true
  alias Chatroom.Host

  @a_host "host"

  setup do
    {:ok, host} = Host.start_link(@a_host)
    %{host: host}
  end

  test "can lookup host by name", %{host: host} do
    {:ok, ^host} = Host.lookup(@a_host)
  end
end