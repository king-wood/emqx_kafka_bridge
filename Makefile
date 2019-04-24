PROJECT = emqx_kafka_bridge
PROJECT_DESCRIPTION = EMQ X Kafka Bridge

DEPS = ekaf grpc_client gpb grpc_client
dep_ekaf = git https://github.com/helpshift/ekaf master
dep_gpb = git https://github.com/tomas-abrahamsson/gpb master
dep_grpc_client = git https://github.com/Bluehouse-Technology/grpc_client master


BUILD_DEPS = emqx cuttlefish
dep_emqx = git https://github.com/emqx/emqx emqx30
dep_cuttlefish = git https://github.com/emqx/cuttlefish emqx30

COVER = true

ERLC_OPTS += +debug_info
ERLC_OPTS += +warnings_as_errors +warn_export_all +warn_unused_import
TEST_ERLC_OPTS += +debug_info

NO_AUTOPATCH = cuttlefish

include erlang.mk

app:: rebar.config

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emqx_kafka_bridge.conf -i priv/emqx_kafka_bridge.schema -d data

