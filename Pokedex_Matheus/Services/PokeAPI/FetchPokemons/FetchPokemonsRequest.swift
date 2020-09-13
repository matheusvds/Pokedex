import Foundation

struct FetchPokemonsRequest: PokeAPIRequest {
    var resource: String {
        return "/pokemon"
    }
    
    var method: String {
        return "GET"
    }
}
