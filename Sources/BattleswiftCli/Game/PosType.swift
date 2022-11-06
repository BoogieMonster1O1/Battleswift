public enum PosType {
    case empty
    case hit
    case miss
    case ship

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
}
