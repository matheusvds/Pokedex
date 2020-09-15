import Foundation

public protocol HttpClient {
    @discardableResult func get(from request: URLRequest, completion: @escaping (Result<Data?, HttpError>) -> Void) -> URLSessionDataTask
}
