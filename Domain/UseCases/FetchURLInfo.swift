import Foundation

public protocol FetchURLInfo {
    func fetch<T: Decodable>(url: String, completion: @escaping (Result<T, FetchError>) -> Void)
}
