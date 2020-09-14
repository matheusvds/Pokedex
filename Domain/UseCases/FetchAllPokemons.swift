import Foundation

public protocol FetchAllPokemons {
    func fetchAllPokemon(for references: [Reference], completion: @escaping (Result<[Pokemon], FetchError>) -> Void)
}
