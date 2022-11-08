open class BaseServer {
    private let properties: ServerProperties
    private var players: [Player] = []
    private var game: ServerGame?
    private var shouldStop = false

    public init(_ properties: ServerProperties) {
        self.properties = properties
    }

    open func start() {
        while !shouldStop {
            tick()
        }
    }

    open func tick() {
        // TODO
        guard let game = game else {
            return
        }
        game.tick()
    }
}
