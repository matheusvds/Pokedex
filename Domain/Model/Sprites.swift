import Foundation

public struct Sprites: Model {
    public let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
