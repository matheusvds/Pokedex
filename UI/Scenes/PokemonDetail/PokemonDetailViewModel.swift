import Foundation

public struct PokemonDetailViewModel {
    public let name: String
    public let image: String
    public let firstType: String
    public let secType: String?
    public let order: String
    
    public init(name: String, image: String, firstType: String, secType: String?, order: String) {
        self.name = name
        self.image = image
        self.firstType = firstType
        self.secType = secType
        self.order = order
    }
}
