import Foundation

// Random Placement, Hunt Algorithm, and Random Targeting
public class Level1AiPlayer: ComputerPlayer {
    open override func inputShips() {
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

    open override func nextShot(otherShot: [Int]?, otherPlayerName: String) -> [Int] {
        // TODO
        return [0, 0]
    }
}
