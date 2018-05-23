-module(emq_auth_prometheus).

-include_lib("emqttd/include/emqttd.hrl").

-behaviour(emqttd_auth_mod).

-export([init/1, check/3, description/0]).

init([Listeners]) ->
    {ok, Listeners}.

check(#mqtt_client{ws_initial_headers = undefined}, _Password, _) ->
    ignore;

check(#mqtt_client{client_id = <<"dashboard_", _/binary>>,
                   username  = <<"dashboard">>,
                   ws_initial_headers = Headers}, _Password, Listeners) ->
    Origin = proplists:get_value("Origin", Headers, ""),
    case is_from_prometheus(Origin, Listeners) of
        true  -> ok;
        false -> ignore
    end;

check(_Client, _Password, _Opts) ->
    ignore.

is_from_prometheus(_Origin, []) ->
    false;
is_from_prometheus(Origin, [{_, Port, _}|Listeners]) ->
    %%TODO: workaround first...
    case string:rstr(Origin, integer_to_list(Port)) of
        0  -> is_from_dashboard(Origin, Listeners);
        _I -> true
    end.

description() ->
    "Prometheus Authentication Module".