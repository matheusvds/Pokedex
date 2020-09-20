import Foundation

public protocol FavoritePokemon {
    func favorite(pokemon: Pokemon, completion: @escaping (Result<Void, FetchError>) -> Void)
}
