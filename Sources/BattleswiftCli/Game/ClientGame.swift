import BattleswiftApi

public class ClientGame {
    public static let sizes = [5, 4, 3, 3, 2];
    public final let player1Board: Board
    public final let player2Board: Board

    public init() {
        player1Board = PlayerBoard()
        player2Board = Board()
    }

    public func start() {
        player1Board.inputShips()
    }
}
