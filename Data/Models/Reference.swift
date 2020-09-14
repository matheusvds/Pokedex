import Foundation

/// Represents a reference to a pokemon. It contains a link that has a full description of a pokemon.
public struct Reference: Model {
    public let name: String
    public let url: String
    
    public init (name: String, url: String) {
        self.name = name
        self.url = url
    }
}
