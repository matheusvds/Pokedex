import Foundation
import Domain

public class RemoteFetchAllPokemons: FetchAllPokemons {
    let client: RequestObject
    
    public init(client: RequestObject) {
        self.client = client
    }
    
    public func fetchAllPokemon(for references: [Reference], completion: @escaping (Result<[Pokemon], FetchError>) -> Void) {
        let group = DispatchGroup()
        var pokemons = [Pokemon?]()
        
        references.forEach { (ref) in
            group.enter()
            fetch(reference: ref) { (data) in
                pokemons.append(data)
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.global()) {
            let pokemons = pokemons.compactMap({ $0 })
            if pokemons.isEmpty {
                return completion(.failure(.errorFetchingData))
            }
            completion(.success(pokemons))
        }
    }
    
    private func fetch(reference: Reference, completion: @escaping (Pokemon?) -> Void) {
        guard let url = URL(string: reference.url) else { return }
        let request = URLRequest(url: url)
        client.fetch(with: request) { (result: Result<Pokemon, RequestError>) in
            switch result {
            case .success(let pokemon):
                completion(pokemon)
            case .failure:
                completion(nil)
            }
        }
    }
}
