import BattleswiftServer

public class IntegratedServer: BaseServer {
    public init() throws {
        super.init(ServerProperties(port: 0, maxPlayers: 2))
    }
}
