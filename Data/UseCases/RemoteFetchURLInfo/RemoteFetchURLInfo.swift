import Domain
import Foundation

public class RemoteFetchURLInfo: FetchURLInfo {
    
    let client: RequestObject
    
    public init(client: RequestObject) {
        self.client = client
    }
    
    public func fetch<T>(url: String, completion: @escaping (Result<T, FetchError>) -> Void)  where T: Decodable {
        guard let url = URL(string: url) else { return completion(.failure(.urlFormatError)) }
        
        client.fetch(with: URLRequest(url: url)) { (result: Result<T, RequestError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure:
                completion(.failure(.errorFetchingData))
            }
        }
    }
}
