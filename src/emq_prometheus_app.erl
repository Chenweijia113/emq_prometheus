-module(emq_prometheus_app).

-author("Chen Weijia <chenweijia@miriding.com>").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-define(APP, emq_prometheus).

start(_Type, _Args) ->
    {ok, Sup} = emq_prometheus_sup:start_link(),
    {ok, Listeners} = application:get_env(?APP, listeners),
    ok = emqttd_access_control:register_mod(auth, emq_auth_prometheus, [Listeners], 9999),
    lists:foreach(fun(Listener) -> start_listener(Listener) end, Listeners),
    emq_prometheus_cli:load(),
    {ok, Sup}.

stop(_State) ->
	emq_prometheus_cli:unload(),
    emqttd_access_control:unregister_mod(auth, emq_auth_prometheus),
    {ok, Listeners} = application:get_env(?APP, listeners),
    lists:foreach(fun(Listener) -> stop_listener(Listener) end, Listeners).

%% start http listener
start_listener({Proto, Port, Options}) when Proto == http orelse Proto == https ->
    mochiweb:start_http(listener_name(Proto), Port, Options, emq_prometheus:http_handler()).

stop_listener({Proto, Port, _}) ->
    mochiweb:stop_http(listener_name(Proto), Port).

listener_name(Proto) -> list_to_atom("prometh:" ++ atom_to_list(Proto)).