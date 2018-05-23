-module(emq_prometheus).

-include_lib("emqttd/include/emqttd.hrl").


-export([dispatcher/0]).

dispatcher() ->
    {ok, _} = application:ensure_all_started(prometheus),
    prometheus_registry:register_collector(prometheus_emq_collector),
    Path = emq_prometheus_config:path(),

    prometheus_http_impl:setup(),

    [{Path ++ "/[:registry]", prometheus_cowboy2_handler, []}].