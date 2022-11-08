import BattleswiftApi

public class IntegratedServer: BaseServer {
    private let player2: ComputerPlayer

    public init(player2: ComputerPlayer) {
        self.player2 = player2
        super.init(ServerProperties(port: 0, maxPlayers: 2))
    }
}
