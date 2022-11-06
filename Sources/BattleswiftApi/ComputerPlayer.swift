public class ComputerPlayer : Player {
    open override func inputShips() {
        // TODO
    }

    open override func nextShot() -> [Int] {
        // TODO
        return [0, 0]
    }

    private func getAvailableShots(otherPlayer: Player) -> [[Int]] {
        var available = [[Int]]()
        for x in 0..<10 {
            for y in 0..<10 {
                switch otherPlayer.getType(x: x, y: y) {
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
