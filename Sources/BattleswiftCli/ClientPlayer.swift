import BattleswiftApi
import Foundation

public class ClientPlayer: Player {
    public let uuid: UUID
    private let humanPlayer = HumanPlayer()

    public init(_ uuid: UUID) {
        self.uuid = uuid
    }

    override open func lose() {
        // TODO
        humanPlayer.lose();
    }

    override open func win() {
        // TODO
        humanPlayer.win();
    }

    override open func onAction(coordinates: [Int], type: PosType) {
        // TODO
        humanPlayer.onAction(coordinates: coordinates, type: type)
    }

    override open func nextShot(otherShot: [Int]?, otherPlayerName: String) -> [Int] {
        // TODO
        let humanShot = humanPlayer.nextShot(otherShot: otherShot, otherPlayerName: otherPlayerName)
        return humanShot
    }

    override open func inputShips() {
        // TODO
        humanPlayer.inputShips()
    }
}
