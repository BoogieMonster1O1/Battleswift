open class BaseServer {
    private let properties: ServerProperties
    private var players: [Player] = []

    public init(_ properties: ServerProperties) {
        self.properties = properties
    }

    open func start() {

    }

    open func tick() {
        
    }
}
