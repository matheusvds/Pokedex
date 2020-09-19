import Foundation

public struct AbilityDetail: Codable {
    public let effectEntries: [EffectEntry]
    public let names: [AbilityDetailName]
    public let pokemon: [AbilityDetail.Pokemon]

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case names, pokemon
    }
    
    public struct Pokemon: Codable {
        public let pokemon: Reference
    }
}

public struct EffectEntry: Codable {
    public let effect: String
    public let language: Reference
    public let shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

public struct AbilityDetailName: Codable {
    public let language: Reference
    public let name: String
}
