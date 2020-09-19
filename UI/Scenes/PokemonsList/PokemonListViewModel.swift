import Foundation

public struct PokemonListViewModel {
    public let items: [PokemonListItem]
    
    public init(items: [PokemonListItem]) {
        self.items = items
    }
}

public struct PokemonListItem {
    public let name: String
    public let image: String
    
    public init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
