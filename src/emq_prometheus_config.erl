-module(emq_prometheus_config).

-export([path/0]).

-define(DEFAULT_PATH, "/metrics").

-define(DEFAULT_MESSAGES_STAT, [messages_sent_total,
                              	messages_received_total,
                              	messages_dropped_total,
                              	messages_retained_total,
                              	messages_get_total,
                              	messages_get_no_ack_total,
                              	messages_deliver_get_total,
                              	messages_redelivered_total,
                              	messages_returned_total]).
-define(DEFAULT_PACKETS_STAT,  [messages_published_total,
                                messages_published_in_total,
                                messages_published_out_total,
                                messages_confirmed_total,
                                messages_delivered_total,
                                messages_delivered_no_ack_total,
                                messages_get_total,
                                messages_get_no_ack_total,
                                messages_deliver_get_total,
                                messages_redelivered_total,
                                messages_returned_total]).
-define(DEFAULT_MEMORY_STAT_ENABLED, false).
-define(DEFAULT_CONNECTIONS_TOTAL_ENABLED, false).

config() ->
  application:get_env(prometheus, rabbitmq_exporter, []).

path() ->
  Config = config(),
  proplists:get_value(path, Config, ?DEFAULT_PATH).

queue_messages_stat() ->
  Config = config(),
  proplists:get_value(messages_stat, Config, ?DEFAULT_MESSAGES_STAT).

exchange_messages_stat() ->
  Config = config(),
  proplists:get_value(packets_stat, Config, ?DEFAULT_PACKETS_STAT).

memory_stat_enabled() ->
  Config = config(),
  proplists:get_value(memory_stat_enabled, Config, ?DEFAULT_MEMORY_STAT_ENABLED).

connections_total_enabled() ->
  Config = config(),
  proplists:get_value(connections_total_enabled, Config, ?DEFAULT_CONNECTIONS_TOTAL_ENABLED).