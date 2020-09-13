import Foundation

struct URLSessionAdapter: HttpClient {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, HttpError>) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(.requestFailed))
            }
            
            if httpResponse.statusCode == 200 {
                guard let model: T = data?.toModel() else {
                    return completion(.failure(.jsonParsingFailure))
                }
                return completion(.success(model))
            }
            
            completion(.failure(.responseUnsuccessful))
        }.resume()
    }
}
