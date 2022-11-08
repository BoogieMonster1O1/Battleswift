import Foundation

public class ServerPlayer: Player {
    public let uuid: UUID

    public init(_ uuid: UUID) {
        self.uuid = uuid
    }

    override open func lose() {
        // TODO
    }

    override open func win() {
        // TODO
    }

    override open func onAction(coordinates: [Int], type: PosType) {
        // TODO
    }

    override open func nextShot(otherShot: [Int]?, otherPlayerName: String) -> [Int] {
        // TODO
        return [0, 0]
    }

    override open func inputShips() {
        // TODO
    }
}
