NIM_COMPILE_CMD ?= nim c --outdir=build
NIM_RUN_CMD ?= $(NIM_COMPILE_CMD) -r

all:

build:
	$(NIM_COMPILE_CMD) src/fletchling.nim

run:
	$(NIM_RUN_CMD) src/fletchling.nim
