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
            print("\u{001B}[2J")
            print("\(player2Board.getName()): ")
            player2Board.display(showShips: false)
            print("")
            print("\(player1Board.getName()): ")
            player1Board.display(showShips: true)
            let player1Coordinates: [Int] = player1Board.nextShot(otherPlayer: player2Board)
            let player1Status = player2Board.hit(coordinates: player1Coordinates)
            player1Board.onAction(coordinates: player1Coordinates, type: player1Status)
            if (player2Board.isLost()) {
                print("\(player1Board.getName()) won!")
                break
            }

            let player2Coordinates: [Int] = player2Board.nextShot(otherPlayer: player1Board)
            let player2Status = player1Board.hit(coordinates: player2Coordinates)
            player2Board.onAction(coordinates: player2Coordinates, type: player2Status)
            if (player1Board.isLost()) {
                print("\(player1Board.getName()) lost :(")
                break
            }
        }
    }
}
