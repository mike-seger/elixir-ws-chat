defmodule WsHandler do
  @behaviour :cowboy_websocket_handler

  def init({:tcp, :http}, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  def websocket_init(_transport_name, req, _opts) do
    :erlang.start_timer(1000, self(), "Hello!")
#    lager.info("Connection from ~s, ~s", [element(9, Req), proplists.get_value(<<"user-agent">>, element(17, Req))])

    {:ok, req, :undefined_state}
  end

  def websocket_handle({:text, msg}, req, state) do
#    %{chatUser: chatUser} = :cowboy_req.match_qs([{:chatUser, [], "unknown"}], req)
#    method = :cowboy_req.method(req)
#    IO.puts chatUser
#    IO.inspect :cowboy_req.match_qs([{chatUser, [], <<"unknown">>}], req)
#    #{ hhchatUser := yChatUser } = cowboy_req:match_qs([{ychatUser, [], <<"unknown">>}], req)
#    Scribe.print(req)
    {:reply, { :text, "That's what she said! #{msg}" }, req, state}
#    {:reply, { :text, "That's what she said! #{msg} #{chatUser}" }, req, state}
  end

  def websocket_handle(_data, req, state) do
    {:ok, req, state}
  end

  def websocket_info({:timeout, _ref, msg}, req, state) do
#    :erlang.start_timer(1000, self(), "How' you doin'?")
    {:reply, {:text, msg}, req, state}
  end

  def websocket_info(_info, req, state) do
    {:ok, req, state}
  end

  def websocket_terminate(_reason, _req, _state) do
    :ok
  end
end
