import Foundation

public protocol FetchReferences {
    func fetchReferences(offset: Int, completion: @escaping (Result<ReferenceList, FetchError>) -> Void)
}
