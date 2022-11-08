import Foundation

public class ServerProperties {
    public static let DEFAULT: ServerProperties = ServerProperties(port: 54332, maxPlayers: 2)
    public let port: Int
    public let maxPlayers: Int

    public init(port: Int, maxPlayers: Int) {
        self.port = port
        self.maxPlayers = maxPlayers
    }

    public func serialize() -> String {
        let dict = [
            "port": port,
            "maxPlayers": maxPlayers
        ]
        var str = ""
        for (key, value) in dict {
            str += "\(key)=\(value)\n"
        }
        return str
    }

    public static func deserialize(_ str: String) throws -> ServerProperties {
        let lines = str.split(separator: "\n")
        var dict = [String: String]()
        for line in lines {
            let parts = line.split(separator: "=")
            if parts.count != 2 {
                throw PropertiesError.malformedProperties
            }
            dict[String(parts[0])] = String(parts[1])
        }
        guard let port = dict["port"], let maxPlayers = dict["maxPlayers"] else {
            throw PropertiesError.missingKey
        }
        return ServerProperties(port: Int(port)!, maxPlayers: Int(maxPlayers)!)
    }

    public static func load() throws -> ServerProperties {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: "server.properties") {
            fileManager.createFile(atPath: "server.properties", contents: DEFAULT.serialize().data(using: .utf8), attributes: nil)
            throw PropertiesError.fileNotFound
        }
        return try deserialize(String(data: fileManager.contents(atPath: "server.properties")!, encoding: .utf8)!)
    }
}

public enum PropertiesError: Error {
    case fileNotFound
    case malformedProperties
    case missingKey
}
