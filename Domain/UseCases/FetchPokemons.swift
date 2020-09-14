import Foundation

public protocol FetchPokemons {
    func fetch(offset: Int, completion: @escaping (Result<[Pokemon], FetchError>) -> Void)
}
