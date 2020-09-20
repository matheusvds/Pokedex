import Foundation

public struct PokemonListViewModel {
    public let items: [PokemonListItem]
    
    public init(items: [PokemonListItem]) {
        self.items = items
    }
}

public struct PokemonListItem {
    public let firstType: String
    public let secType: String?
    public let name: String
    public let image: String
    
    public init(name: String, image: String, firstType: String, secType: String?) {
        self.firstType = firstType
        self.secType = secType
        self.name = name
        self.image = image
    }
}
