import Foundation

public struct PokemonDetailViewModel {
    public let name: String
    public let firstType: String
    public let secType: String?
    public let order: String
    
    public init(name: String, firstType: String, secType: String?, order: String) {
        self.name = name
        self.firstType = firstType
        self.secType = secType
        self.order = order
    }
}
