public enum PosType {
    case empty
    case hit(ShipType)
    case miss
    case ship(ShipType)

    func character(showShips: Bool) -> Character {
        switch self {
        case .empty:
            return "."
        case .hit:
            return "X"
        case .miss:
            return "O"
        case .ship:
            return showShips ? "$" : "."
        }
    }

    func isShip() -> Bool {
        switch self {
        case .ship:
            return true
        default:
            return false
        }
    }

    func getShipType() -> ShipType {
        switch self {
        case .ship(let shipType):
            return shipType
        case .hit(let shipType):
            return shipType
        default:
            fatalError()
        }
    }
}
