import Foundation

protocol FetchPokemons {
    func fetchPokemons(offset: Int, completion: @escaping (Result<PokemonListModel, FetchPokemonError>) -> Void)
}
