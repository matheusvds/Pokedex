import Foundation

protocol PokeAPIRequest {
    var resource: String { get }
    var method: String { get }
}

extension PokeAPIRequest {
    var baseURL: String {
        return "https://pokeapi.co/api/v2"
    }
    
    var url: URL {
        return URL(string: baseURL)!.appendingPathComponent(resource)
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
