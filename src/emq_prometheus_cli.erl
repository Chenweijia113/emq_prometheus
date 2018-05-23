-module(emq_prometheus_cli).

-include_lib("emqttd/include/emqttd.hrl").

-export([load/0, unload/0]).

%% Called when the plugin application start
load() ->
	io:format("start emq_prometheue plugin~n", []).

%% Called when the plugin application stop
unload() ->
	io:format("stop emq_prometheue plugin~n", []).
