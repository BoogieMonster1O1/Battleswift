import BattleswiftApi

public class ClientGame: Game {
    public static let sizes = [5, 4, 3, 3, 2];
    public final let player1Board: Player
    public final let player2Board: Player

    public init() {
        player1Board = ClientPlayer()
        player2Board = Level2AiPlayer()
    }

    public func preInit() {

    }

    public func tick() {
        
    }

    public func start() {
        player1Board.inputShips()
        player2Board.inputShips()
        var player2Coordinates: [Int]? = nil
        while (true) {
            let player1Coordinates = player1Board.nextShot(otherShot: player2Coordinates, otherPlayerName: player2Board.getName())
            let player1Status = player2Board.hit(coordinates: player1Coordinates)
            player1Board.onAction(coordinates: player1Coordinates, type: player1Status)
            if (player2Board.isLost()) {
                player2Board.lose()
                player1Board.win()
                break
            }
            player2Coordinates = player2Board.nextShot(otherShot: player1Coordinates, otherPlayerName: player1Board.getName())
            guard let player2Coordinates = player2Coordinates else {
                fatalError()
            }
            let player2Status = player1Board.hit(coordinates: player2Coordinates)
            player2Board.onAction(coordinates: player2Coordinates, type: player2Status)
            if (player1Board.isLost()) {
                player1Board.lose();
                player2Board.win();
                break
            }
        }
    }
}
