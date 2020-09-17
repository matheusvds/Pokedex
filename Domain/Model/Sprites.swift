import Foundation

public struct Sprites: Model {
    public let frontDefault: String
    public let other: Other

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
    
    public struct Other: Codable {
        public let officialArtwork: OfficialArtwork

        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    public struct OfficialArtwork: Codable {
        public let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
