import Foundation

public struct PokemonListModel: Model {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [PokemonModel]
    
    
    public init(count: Int, next: String?, previous: String?, results: [PokemonModel]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
