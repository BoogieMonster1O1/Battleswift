public class ComputerPlayer : Player {
    open override func inputShips() {
        // TODO
    }

    open override func nextShot(otherPlayer: Player) -> [Int] {
        // TODO
        return [0, 0]
    }

    private func getAvailableShots(otherPlayer: Player) -> [[Int]] {
        var available = [[Int]]()
        for x in 0..<10 {
            for y in 0..<10 {
                if otherPlayer.getType(x: x, y: y) == .empty {
                    available.append([x, y])
                }
            }
        }
        return available
    }

    open override func getName() -> String {
        return "Computer"
    }
}
