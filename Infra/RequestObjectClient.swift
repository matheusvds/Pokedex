import Foundation
import Data

public struct RequestObjectClient: RequestObject {
    
    let client: HttpClient
    
    public init(client: HttpClient) {
        self.client = client
    }
    
    public func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, RequestError>) -> Void) {
        client.send(from: request) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return completion(.failure(.responseUnsuccessful))  }
                guard let model: T = data.toModel() else { return completion(.failure(.jsonParsingFailure)) }
                completion(.success(model))
            case .failure:
                completion(.failure(.requestFailed))
            }
        }
    }
}
