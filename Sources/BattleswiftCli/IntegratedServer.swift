import BattleswiftServer
import BattleswiftApi

public class IntegratedServer: BaseServer {
    public init(player2: Player) {
        super.init(ServerProperties(port: 0, maxPlayers: 2))
    }
}
