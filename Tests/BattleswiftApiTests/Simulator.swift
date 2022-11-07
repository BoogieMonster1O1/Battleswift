import XCTest
import BattleswiftApi

final class Simulator: XCTestCase {
    func testSimulate() throws {
        var moves: [Int] = []
        for _ in 0..<400 {
            let player1 = NoopPlayer()
            player1.inputShips()
            let player2 = Level2AiPlayer()
            player2.inputShips()
            var counter = 0
            while true {
                let player2Coordinates = player2.nextShot(otherShot: [0, 0], otherPlayerName: "no")
                let player2Status = player1.hit(coordinates: player2Coordinates)
                player2.onAction(coordinates: player2Coordinates, type: player2Status)
                counter += 1
                if (player1.isLost()) {
                    moves.append(counter)
                    break
                }
            }
        }
        moves.sort()
        print("Median: \(moves[moves.count / 2])")
        print("Average: \(moves.reduce(0, +) / moves.count)")
        let x = Array(1...400)
        let fin = zip(moves, x).flatMap { [$0, $1] }

        print(fin.reduce("", { $0 + " \($1)"}))
    }
}

final class NoopPlayer: ComputerPlayer {
    public override func nextShot(otherShot: [Int]?, otherPlayerName: String) -> [Int] {
        return [0, 0]
    }

    public override func inputShips() {
        let available = self.getAvailableShots();
        for shipType in ShipType.allCases {
            while true {
                let coordinate = available[Int.random(in: 0..<available.count)]
                let x = coordinate[0]
                let y = coordinate[1]
                let horizontal = Bool.random()
                // Validate
                if x + shipType.getSize() > 10 && horizontal {
                    continue
                }
                if y + shipType.getSize() > 10 && !horizontal {
                    continue
                }
                if !self.noOverlap(x: x, y: y, size: shipType.getSize(), orientation: horizontal ? .horizontal : .vertical) {
                    continue
                }
                for i in 0..<shipType.getSize() {
                    if horizontal {
                        self.setType(x: x + i, y: y, type: .ship(shipType))
                    } else {
                        self.setType(x: x, y: y + i, type: .ship(shipType))
                    }
                }
                break
            }
        }
    }
}
