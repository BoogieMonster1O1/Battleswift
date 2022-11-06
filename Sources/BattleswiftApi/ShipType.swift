public enum ShipType: CaseIterable {
    case carrier
    case battleship
    case cruiser
    case submarine
    case destroyer

    public func getSize() -> Int {
        switch self {
        case .carrier:
            return 5
        case .battleship:
            return 4
        case .cruiser:
            return 3
        case .submarine:
            return 3
        case .destroyer:
            return 2
        }
    }

    public func getName() -> String {
        switch self {
        case .carrier:
            return "Carrier"
        case .battleship:
            return "Battleship"
        case .cruiser:
            return "Cruiser"
        case .submarine:
            return "Submarine"
        case .destroyer:
            return "Destroyer"
        }
    }
}
