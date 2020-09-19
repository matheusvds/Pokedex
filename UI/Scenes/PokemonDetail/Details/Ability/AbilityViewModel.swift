import Foundation

public struct AbilityViewModel {
    public let name: String?
    public let abilityDescription: String?
    public let pokemons: [String]
    
    public init(name: String?, abilityDescription: String?, pokemons: [String]) {
        self.name = name
        self.abilityDescription = abilityDescription
        self.pokemons = pokemons
    }
}
