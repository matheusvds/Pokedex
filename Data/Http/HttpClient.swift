import Foundation

public protocol HttpClient {
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, HttpError>) -> Void)
}
