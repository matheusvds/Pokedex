import Foundation

protocol FetchPokemons {
    func fetchPokemons(completion: @escaping (Result<PokemonListModel, FetchPokemonError>) -> Void)
}
