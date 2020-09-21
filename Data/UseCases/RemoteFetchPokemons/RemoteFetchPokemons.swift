import Foundation
import Domain

public class RemoteFetchPokemons: FetchPokemons {
    let fetchReferences: FetchReferences
    let fetchAllPokemons: FetchAllPokemons
    
    public init(fetchReferences: FetchReferences,
         fetchAllPokemons: FetchAllPokemons) {
        self.fetchReferences = fetchReferences
        self.fetchAllPokemons = fetchAllPokemons
    }
    
    public func fetch(offset: Int, completion: @escaping (Result<[Pokemon], FetchError>) -> Void) {
        fetchReferences.fetchReferences(offset: offset) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let references):
                self.fetchAllPokemons.fetchAllPokemon(for: references.results) { (result) in
                    switch result {
                    case .success(let pokemons):
                        completion(.success(pokemons))
                    case .failure:
                        completion(.failure(.errorFetchingData))
                    }
                }
                
            case .failure:
                completion(.failure(.errorFetchingData))
            }
        }
    }
}
