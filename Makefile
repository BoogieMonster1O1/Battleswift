.PHONY: build

build:
	swift build

cli: build
	.build/x86_64-unknown-linux-gnu/debug/BattleswiftCli

prerequisites: build

target: prerequisites 
