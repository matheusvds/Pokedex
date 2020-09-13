import Foundation

protocol FetchReferences {
    func fetchReferences(offset: Int, completion: @escaping (Result<ReferenceList, FetchReferenceError>) -> Void)
}
