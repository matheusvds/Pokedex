import Foundation

public protocol RequestObject {
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, RequestError>) -> Void)
}
