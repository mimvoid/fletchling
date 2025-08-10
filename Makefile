NIM_COMPILE_CMD ?= nim c --outdir=build
NIM_RUN_CMD ?= $(NIM_COMPILE_CMD) -r

all:

build:
	$(NIM_COMPILE_CMD) src/fletchling.nim

run:
	$(NIM_RUN_CMD) src/fletchling.nim

test:
	$(NIM_RUN_CMD) tests/testAll.nim

print-mono:
	$(NIM_RUN_CMD) tests/printMonoArt.nim

print-styled:
	$(NIM_RUN_CMD) tests/printStyledArt.nim
