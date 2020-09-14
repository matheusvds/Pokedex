import Foundation

public struct Pokemon: Model {
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
    public let game_indices: [GameIndex]
}
