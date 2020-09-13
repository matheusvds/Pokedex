import Foundation

class RemoteFetchPokemons: FetchPokemons {
    
    let client: HttpClient
    
    init(client: HttpClient = URLSessionAdapter()) {
        self.client = client
    }
    
    func fetchPokemons(completion: @escaping (Result<PokemonListModel, FetchPokemonError>) -> Void) {
        let request = FetchPokemonsRequest().request
        client.fetch(with: request) { (result: Result<PokemonListModel, HttpError>) in
            switch result {
            case .success(let pokemonList):
                completion(.success(pokemonList))
            case .failure:
                completion(.failure(.errorFetchingData))
            }
        }
    }
}
