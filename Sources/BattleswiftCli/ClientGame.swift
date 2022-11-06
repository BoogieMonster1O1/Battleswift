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
        var message: String? = nil
        while (true) {
            print("\u{001B}[2J")
            if let message = message {
                print(message)
            }
            print("\(player2Board.getName()): ")
            player2Board.display(showShips: false)
            print("")
            print("\(player1Board.getName()): ")
            player1Board.display(showShips: true)
            let player1Coordinates: [Int] = player1Board.nextShot()
            let player1Status = player2Board.hit(coordinates: player1Coordinates)
            player1Board.onAction(coordinates: player1Coordinates, type: player1Status)
            if (player2Board.isLost()) {
                print("\(player1Board.getName()) won!")
                break
            }

            let player2Coordinates: [Int] = player2Board.nextShot()
            let player2Status = player1Board.hit(coordinates: player2Coordinates)
            player2Board.onAction(coordinates: player2Coordinates, type: player2Status)
            message = "\(player2Board.getName()) played \(Character(UnicodeScalar(player2Coordinates[0] + 65)!)), \(player2Coordinates[1])"
            if (player1Board.isLost()) {
                print("\(player1Board.getName()) lost :(")
                break
            }
        }
    }
}
