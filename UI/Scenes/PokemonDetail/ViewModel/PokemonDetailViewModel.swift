import Foundation

public struct PokemonDetailViewModel {
    public let name: String
    public let height: String
    public let weight: String
    
    public init(name: String, height: String, weight: String) {
        self.name = name
        self.height = height
        self.weight = weight
    }
}
