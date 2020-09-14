import Foundation

public struct GameIndex: Codable {
    public let gameIndex: Int
    public let version: Reference

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}
