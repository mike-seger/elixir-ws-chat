defmodule WsCowboy do
  @behaviour :application

  def start(_type, _args) do
    dispatch = :cowboy_router.compile([
      {:_, [
        {"/", :cowboy_static, {:priv_file, :ws_cowboy, "index.html"}},
        {"/websocket", WsHandler, []},
        {"/static/[...]", :cowboy_static, {:priv_dir, :ws_cowboy, "static"}}
      ]}
    ])
    {:ok, _} = :cowboy.start_http(:http, 100, [{:port, 8882}],
                                  [{:env, [{:dispatch, dispatch}]}])
    WsSupervisor.start_link
  end

  def stop(_state) do
    :ok
  end
end
