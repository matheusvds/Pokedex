import Foundation

public class RemoteFetchReferences: FetchReferences {
    
    let client: HttpClient
    
    public init(client: HttpClient = URLSessionAdapter()) {
        self.client = client
    }
    
    public func fetchReferences(offset: Int, completion: @escaping (Result<ReferenceList, FetchReferenceError>) -> Void) {
        let request = FetchReferencesRequest(offset: offset).request
        client.fetch(with: request) { (result: Result<ReferenceList, HttpError>) in
            switch result {
            case .success(let pokemonList):
                completion(.success(pokemonList))
            case .failure:
                completion(.failure(.errorFetchingData))
            }
        }
    }
}
