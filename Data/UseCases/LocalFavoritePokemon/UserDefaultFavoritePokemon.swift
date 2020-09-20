import Foundation
import Domain

public class UserDefaultFavoritePokemon: LocalFavoritePokemon {
    
    public init() { }
    
    public func favorite(pokemon: Pokemon) -> Bool {
        let saved = UserDefaults.standard.bool(forKey: "\(pokemon.id)")
        UserDefaults.standard.set(!saved, forKey: "\(pokemon.id)")
        return !saved
    }
}
