import Foundation

struct FetchPokemonsRequest {
    
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
extension FetchPokemonsRequest: PokeAPIRequest {
    var queryItems: [URLQueryItem]? {
        return makeQueryItems()
    }
    
    var resource: String {
        return "pokemon"
    }
    
    var method: String {
        return "GET"
    }
}
