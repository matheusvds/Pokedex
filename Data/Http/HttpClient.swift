import Foundation

public protocol HttpClient {
    @discardableResult func send(from request: URLRequest, completion: @escaping (Result<Data?, HttpError>) -> Void) -> URLSessionDataTask
}
