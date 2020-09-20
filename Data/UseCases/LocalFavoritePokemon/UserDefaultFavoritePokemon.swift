import Foundation
import Domain

public class UserDefaultFavoritePokemon: LocalFavoritePokemon {
    public init() { }
    
    public func setFavorite(pokemon: Pokemon) {
        UserDefaults.standard.set(pokemon.favorited, forKey: "\(pokemon.id)")
    }
    
    public func isFavorited(pokemon: Pokemon) -> Bool {
        return UserDefaults.standard.bool(forKey: "\(pokemon.id)")
    }
}
