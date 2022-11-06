.PHONY: build

build:
	swift build

cli: build
	.build/x86_64-unknown-linux-gnu/debug/BattleswiftCli

server: build
	.build/x86_64-unknown-linux-gnu/debug/BattleswiftServer

prerequisites: build

target: prerequisites 
