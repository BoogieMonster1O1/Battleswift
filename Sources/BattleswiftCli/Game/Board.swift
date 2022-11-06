public class Board {
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

    public func getType(x: Int, y: Int) -> PosType {
        return positions[x][y]
    }

    public func setType(x: Int, y: Int, type: PosType) {
        positions[x][y] = type
    }

    public func display(showShips: Bool) {
        var numbers = "  "
        for i in 0..<10 {
            numbers += "\(Character(UnicodeScalar(i + 65)!)) "
        }
        print(numbers)
        for i in 0..<10 {
            let row = positions[i]
            var line = "\(i) "
            for pos in row {
                line += String(pos.character(showShips: showShips)) + " "
            }
            print(line)
        }
    }
}
