import Foundation
import Data
import Domain

class RequestObjectSpy: RequestObject {
    var requests: [URLRequest] = []
    var referenceListCallback: ((Result<ReferenceList, RequestError>) -> Void)!
    var pokemonCallback: ((Result<Pokemon, RequestError>) -> Void)!
    
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, RequestError>) -> Void) {
        requests.append(request)
        
        if let callback = completion as? ((Result<ReferenceList, RequestError>) -> Void) {
            referenceListCallback = callback
        }
        
        if let callback = completion as? ((Result<Pokemon, RequestError>) -> Void) {
            pokemonCallback = callback
        }
    }
    
    func complete(withError error: RequestError) {
        pokemonCallback?(.failure(error))
        referenceListCallback?(.failure(error))
    }
    
    func complete(withPokemon pokemon: Pokemon) {
        pokemonCallback!(.success(pokemon))
    }
    
    func complete(withList pokemonList: ReferenceList) {
        referenceListCallback!(.success(pokemonList))
    }
}
