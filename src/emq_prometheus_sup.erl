-module(emq_prometheus_sup).

-author("Chen Weijia <chenweijia@miriding.com>").

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(M, emq_prometheus).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    {ok, { {one_for_one, 0, 1}, []} }.
