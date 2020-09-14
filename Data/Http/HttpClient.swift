import Foundation

public protocol HttpClient {
    func get(from request: URLRequest, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
