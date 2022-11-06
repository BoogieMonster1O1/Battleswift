open class Board {
    private final var positions: [[PosType]] = [[PosType]]()

    public init() {
        for _ in 0..<10 {
            var row: [PosType] = [PosType]()
            for _ in 0..<10 {
                row.append(PosType.empty)
            }
            positions.append(row)
        }
    }

    public func noOverlap(x: Int, y: Int, size: Int, orientation: Orientation) -> Bool {
        for i in 0..<size {
            if orientation == .horizontal {
                if getType(x: x + i, y: y) == .ship {
                    return false
                }
            } else {
                if getType(x: x, y: y + i) == .ship {
                    return false
                }
            }
        }
        return true
    }

    public func getType(x: Int, y: Int) -> PosType {
        return positions[x][y]
    }

    public func setType(x: Int, y: Int, type: PosType) {
        positions[x][y] = type
    }

    public func display(showShips: Bool) {
        var numbers = "  "
        for i in 0..<10 {
            numbers += "\(i) "
        }
        print(numbers)
        for i in 0..<10 {
            let row = positions[i]
            var line = "\(Character(UnicodeScalar(i + 65)!)) "
            for pos in row {
                line += String(pos.character(showShips: showShips)) + " "
            }
            print(line)
        }
    }

    open func inputShips() {
        fatalError(String(describing: self) + " does not implement inputShips()")
    }
}

public enum Orientation {
    case horizontal
    case vertical
}
