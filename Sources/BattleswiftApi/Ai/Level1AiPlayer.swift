import Foundation

// Random Placement, Hunt Algorithm, and Parity Targeting
public class Level1AiPlayer: ComputerPlayer {
    private final var huntStack = [[Int]]()
    private final var fiveParity = [[Int]]()
    private final var fourParity = [[Int]]()
    private final var threeParity = [[Int]]()
    private final var twoParity = [[Int]]()
    private var lastShot: [Int]? = nil

    public override init() {
        for i in 0..<10 {
            for j in 0..<10 {
                let num = i + j
                if num % 5 == 0 {
                    fiveParity.append([i, j])
                }
                if num % 3 == 0 {
                    threeParity.append([i, j])
                }
                if num % 2 == 0 {
                    print("\(num) \(i) \(j)")
                    twoParity.append([i, j])
                    if num % 4 == 0 {
                        fourParity.append([i, j])
                    }
                }
            }
        }
        let thing = readLine()
        print(thing)
    }

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
        let available = self.getAvailableShots()
        var parityList = getParityList(size: getSmallestUnsunkSize())
        var paritySet = Set(parityList).intersection(Set(available))
        if lastShot == nil || huntStack.count == 0 {
            self.lastShot = paritySet.shuffled().first!
            parityList.remove(at: parityList.firstIndex(of: self.lastShot!)!)
            return self.lastShot!
        }
        guard let lastShot = lastShot else {
            fatalError()
        }
        if self.partialOtherBoard[lastShot[0]][lastShot[1]].isHit() {
            tryAdd(x: lastShot[0] + 1, y: lastShot[0])
            tryAdd(x: lastShot[0] - 1, y: lastShot[0])
            tryAdd(x: lastShot[0], y: lastShot[0] + 1)
            tryAdd(x: lastShot[0], y: lastShot[0] - 1)
        }
        return huntStack.remove(at: 0)
    }

    private func tryAdd(x: Int, y: Int) {
        if x < 10 && x >= 0 && y < 10 && y >= 0 {
            return
        } else if !isEmptyPos(x: x, y: y) {
            return
        }
        self.huntStack.insert([x, y], at: 0)
    }

    private func isEmptyPos(x: Int, y: Int) -> Bool {
        let type = self.partialOtherBoard[x][y]
        switch type {
        case .empty:
            return true
        default:
            return false
        }
    }

    private func getSmallestUnsunkSize() -> Int {
        var smallest = ShipType.carrier
        for shipType in ShipType.allCases {
            var sinkCount = 0
            for row in self.partialOtherBoard {
                for cell in row {
                    if cell.isHit() {
                        if cell.getShipType() == shipType {
                            sinkCount += 1
                        }
                    }
                }
            }
            if sinkCount == shipType.getSize() {
                continue
            }
            if shipType.getSize() < smallest.getSize() {
                smallest = shipType
            }
        }
        return smallest.getSize()
    }

    private func getParityList(size: Int) -> [[Int]] {
        switch size {
        case 5:
            return self.fiveParity
        case 4:
            return self.fourParity
        case 3:
            return self.threeParity
        case 2:
            return self.twoParity
        default:
            fatalError()
        }
    }
}
