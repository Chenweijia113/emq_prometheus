PROJECT = emq_prometheus
PROJECT_DESCRIPTION = Prometheus.io exporter as a EMQ Plugin plugin
PROJECT_VERSION = 2.3.9

BUILD_DEPS = emqttd cuttlefish prometheus prometheus_httpd accept \
			prometheus_process_collector
dep_emqttd = git https://github.com/emqtt/emqttd master
dep_cuttlefish = git https://github.com/emqtt/cuttlefish
dep_prometheus = git https://github.com/deadtrickster/prometheus.erl master
dep_prometheus_process_collector = git https://github.com/deadtrickster/prometheus_process_collector master
dep_prometheus_httpd = git https://github.com/deadtrickster/prometheus-httpd master
dep_accept = git https://github.com/deadtrickster/accept	

ERLC_OPTS += +debug_info
ERLC_OPTS += +'{parse_transform, lager_transform}'

NO_AUTOPATCH = cuttlefish

COVER = true

include erlang.mk

app:: rebar.config

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emq_prometheus.conf -i priv/emq_prometheus.schema -d data
