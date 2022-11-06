import BattleswiftApi

public class ClientGame {
    public static let sizes = [5, 4, 3, 3, 2];
    public final let player1Board: Player
    public final let player2Board: Player

    public init() {
        player1Board = HumanPlayer()
        player2Board = ComputerPlayer()
    }

    public func start() {
        player1Board.inputShips()
        player2Board.inputShips()
        while (true) {
            let player1Coordinates = player1Board.inputShot()
        }
    }
}
