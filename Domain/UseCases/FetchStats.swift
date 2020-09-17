import Foundation

public protocol FetchStats {
    func fetch(url: String, completion: @escaping (Result<[Pokemon], FetchError>) -> Void)
}
