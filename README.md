# Battleswift

A command line Battleship client written in Swift.

## Building
- `swift build` - Build the project to .build
- `swift run BattleswiftCli` - Build the project and run the command line client
- `swift run BattleswiftServer` - Build the project and run the dedicated server

Supports Singleplayer and Multiplayer.  

### Singleplayer
Singleplayer is against a computer opponent. Two different difficulty levels are available.
- Level 1: Hunt + Parity Algorithm
- Level 2: Probabilistic heat map. Median win moves: 44

### Multiplayer
Allows connecting to a dedicated server or a client with a server running locally. Uses web socket.  
A single dedicated server can support multiple games. Each player is paired with the next person that joins.  
In the case of a server being run by a client, only a single client can join.
