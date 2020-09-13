import Foundation

protocol PokeAPIRequest {
    var resource: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension PokeAPIRequest {
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "pokeapi.co"
    }
    
    var path: String {
        return "/api/v2/" + resource
    }
    
    var serviceURL: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        return components.url!
    }
    
    var request: URLRequest {
        var request = URLRequest(url: serviceURL)
        request.httpMethod = method
        return request
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
