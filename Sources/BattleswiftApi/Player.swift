open class Player {
    public var board: [[PosType]] = [[PosType]]()
    public var partialOtherBoard: [[PosType]] = [[PosType]]()

    public init() {
        for _ in 0..<10 {
            var row: [PosType] = [PosType]()
            for _ in 0..<10 {
                row.append(PosType.empty)
            }
            board.append(row)
        }
        for _ in 0..<10 {
            var row: [PosType] = [PosType]()
            for _ in 0..<10 {
                row.append(PosType.empty)
            }
            partialOtherBoard.append(row)
        }
    }

    public func noOverlap(x: Int, y: Int, size: Int, orientation: Orientation) -> Bool {
        for i in 0..<size {
            if orientation == .horizontal {
                if getType(x: x + i, y: y).isShip() {
                    return false
                }
            } else {
                if getType(x: x, y: y + i).isShip() {
                    return false
                }
            }
        }
        return true
    }

    public func getType(x: Int, y: Int) -> PosType {
        return board[x][y]
    }

    public func setType(x: Int, y: Int, type: PosType) {
        board[x][y] = type
    }

    public func display(showShips: Bool) {
        return Player.display(types: self.board, showShips: true)
    }

    public static func display(types: [[PosType]], showShips: Bool) {
        var numbers = "  "
        for i in 0..<10 {
            numbers += "\(i) "
        }
        print(numbers)
        for i in 0..<10 {
            let row = types[i]
            var line = "\(Character(UnicodeScalar(i + 65)!)) "
            for pos in row {
                line += String(pos.character(showShips: showShips)) + " "
            }
            print(line)
        }
    }

    open func lose() {
        // NO-OP
    }

    open func win() {
        // NO-OP
    }

    open func inputShips() {
        fatalError(String(describing: self) + " does not implement inputShips()")
    }

    open func nextShot(otherShot: [Int]?, otherPlayerName: String) -> [Int] {
        fatalError(String(describing: self) + " does not implement nextShot()")
    }

    open func onAction(coordinates: [Int], type: PosType) {
        partialOtherBoard[coordinates[0]][coordinates[1]] = type
    }

    public func hit(coordinates: [Int]) -> PosType {
        if getType(x: coordinates[0], y: coordinates[1]).isShip() {
            let type = getType(x: coordinates[0], y: coordinates[1]).getShipType()
            setType(x: coordinates[0], y: coordinates[1], type: .hit(type))
            return .hit(type)
        } else {
            setType(x: coordinates[0], y: coordinates[1], type: .miss)
            return .miss
        }
    }

    public func isLost() -> Bool {
        for row in board {
            for pos in row {
                if pos.isShip() {
                    return false
                }
            }
        }
        return true
    }

    open func getName() -> String {
        return "Player"
    }
}

public enum Orientation {
    case horizontal
    case vertical
}
