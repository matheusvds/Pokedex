import Foundation

public struct Pokemon: Model {
    public let uuid = UUID()
    public var favorited = false
    public let abilities: [Ability]
    public let height: Int
    public let id: Int
    public let moves: [Move]
    public let name: String
    public let order: Int
    public let sprites: Sprites
    public let stats: [Stat]
    public let types: [TypeElement]
    public let weight: Int
    public let gamesIndices: [GameIndex]
    
    enum CodingKeys: String, CodingKey {
        case abilities, height, id, moves, name, order, sprites, stats, types, weight
        case gamesIndices = "game_indices"
    }
}
