all:

build:
	nim c --outdir=build src/fletchling.nim

run:
	nim c --outdir=build -r src/fletchling.nim
