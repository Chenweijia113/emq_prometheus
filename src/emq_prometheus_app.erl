-module(emq_prometheus_app).

-author("Chen Weijia <chenweijia@miriding.com>").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-define(APP, emq_prometheus).

start(_Type, _Args) ->
    {ok, Sup} = emq_prometheus_sup:start_link(),
    emq_prometheus_cli:load(),
    {ok, Sup}.

stop(_State) ->
	emq_prometheus_cli:unload().

%% start http listener
% start_listener({Proto, Port, Options}) when Proto == http orelse Proto == https ->
%     mochiweb:start_http(listener_name(Proto), Port, Options, emq_prometheus:http_handler()).

% stop_listener({Proto, Port, _}) ->
%     mochiweb:stop_http(listener_name(Proto), Port).

% listener_name(Proto) -> list_to_atom("prometh:" ++ atom_to_list(Proto)).