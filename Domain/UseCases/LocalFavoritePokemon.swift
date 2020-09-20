import Foundation

public protocol LocalFavoritePokemon {
    func setFavorite(pokemon: Pokemon)
    func isFavorited(pokemon: Pokemon) -> Bool
}
