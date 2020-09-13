import Foundation

public struct FetchReferencesRequest {
    
    let offset: Int
    let limit: Int
    
    init(offset: Int = 20, limit: Int = 20) {
        self.offset = offset
        self.limit = limit
    }
    
    private func makeQueryItems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
    }
}

// MARK: - PokeAPIRequest
extension FetchReferencesRequest: PokeAPIRequest {
    public var queryItems: [URLQueryItem]? {
        return makeQueryItems()
    }
    
    public var resource: String {
        return "pokemon"
    }
    
    public var method: String {
        return "GET"
    }
}
