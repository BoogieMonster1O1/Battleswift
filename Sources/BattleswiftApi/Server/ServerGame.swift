public class ServerGame: Game {
    public let player1: ServerPlayer
    public let player2: ServerPlayer
    private var player2Coordinates: [Int]? = nil

    public init(player1: ServerPlayer, player2: ServerPlayer) {
        self.player1 = player1
        self.player2 = player2
    }

    public func preInit() {
        player1.inputShips()
        player2.inputShips()
    }

    public func tick() {
        let player1Coordinates = player1.nextShot(otherShot: player2Coordinates, otherPlayerName: player2.getName())
        let player1Status = player2.hit(coordinates: player1Coordinates)
        player1.onAction(coordinates: player1Coordinates, type: player1Status)
        if (player2.isLost()) {
            player2.lose()
            player1.win()
            return
        }
        let player2Coordinates = player2.nextShot(otherShot: player1Coordinates, otherPlayerName: player1.getName())
        let player2Status = player1.hit(coordinates: player2Coordinates)
        player2.onAction(coordinates: player2Coordinates, type: player2Status)
        if (player1.isLost()) {
            player1.lose();
            player2.win();
            return
        }
    }
}
