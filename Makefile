PROJECT = emqx_kafka_bridge
PROJECT_DESCRIPTION = EMQ X Kafka Bridge

DEPS = ekaf 
dep_ekaf = git https://github.com/helpshift/ekaf master

BUILD_DEPS = emqx cuttlefish grpc_client grpc_lib http2_client gpb
dep_emqx = git https://github.com/emqx/emqx emqx30
dep_cuttlefish = git https://github.com/emqx/cuttlefish emqx30
dep_gpb = git https://github.com/tomas-abrahamsson/gpb master
dep_grpc_client = git https://github.com/Bluehouse-Technology/grpc_client master
dep_http2_client = git https://github.com/Bluehouse-Technology/http2_client master
dep_grpc_lib = git https://github.com/Bluehouse-Technology/grpc_lib master

COVER = true

ERLC_OPTS += +debug_info
ERLC_OPTS += +warnings_as_errors +warn_export_all +warn_unused_import
TEST_ERLC_OPTS += +debug_info

NO_AUTOPATCH = cuttlefish

include erlang.mk

app:: rebar.config

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emqx_kafka_bridge.conf -i priv/emqx_kafka_bridge.schema -d data

