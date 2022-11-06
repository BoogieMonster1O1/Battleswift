.PHONY: build

build:
	swift build

cli: build
	$(shell swift build --show-bin-path)/BattleswiftCli

server: build
	$(shell swift build --show-bin-path)/BattleswiftServer

prerequisites: build

target: prerequisites 
