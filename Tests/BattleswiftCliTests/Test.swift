import XCTest
import class Foundation.Bundle
import BattleswiftCli

final class Test: XCTestCase {
    func testExample() throws {
        let board = Board()
        board.display(showShips: true)
    }
}
