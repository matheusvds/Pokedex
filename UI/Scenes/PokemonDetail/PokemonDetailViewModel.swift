import Foundation

public struct PokemonDetailViewModel {
    public let name: String
    public let image: String
    public let favorited: Bool
    public let firstType: String
    public let secType: String?
    public let order: String
    
    public init(name: String, image: String, favorited: Bool, firstType: String, secType: String?, order: String) {
        self.name = name
        self.image = image
        self.favorited = favorited
        self.firstType = firstType
        self.secType = secType
        self.order = order
    }
}
