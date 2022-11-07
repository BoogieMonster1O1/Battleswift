open class ComputerPlayer : Player {
    public func getAvailableShots() -> [[Int]] {
        var available = [[Int]]()
        for x in 0..<10 {
            for y in 0..<10 {
                switch self.partialOtherBoard[x][y] {
                case .empty, .ship:
                    available.append([x, y])
                    break
                default:
                    break
                }
            }
        }
        return available
    }

    open override func getName() -> String {
        return "Computer"
    }
}
