import BattleswiftApi

print("Welcome to Battleswift!")
print("Choose a game mode:")
print("1. Singleplayer Level 1")
print("2. Singleplayer Level 2")
print("3. Multiplayer")

var choice: Character
repeat {
    choice = readLine()!.first!
} while choice != "1" && choice != "2" && choice != "3"

switch choice {
case "1":
    print("not implemented yet")
case "2":
    let server = IntegratedServer(player2: Level2AiPlayer()) // TODO
    let game = ClientGame()
    game.start()
case "3":
    print("not implemented yet")
default:
    fatalError()
}
