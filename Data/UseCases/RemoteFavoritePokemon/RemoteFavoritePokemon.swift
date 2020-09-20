import Foundation
import Domain

public final class RemoteFavoritePokemon: FavoritePokemon {
    
    let client: HttpClient
    
    public init(client: HttpClient) {
        self.client = client
    }
    
    public func favorite(pokemon: Pokemon, completion: @escaping (Result<Void, FetchError>) -> Void) {
        let webhookURL = "https://webhook.site/3209dcca-c16d-4d48-8854-77bae12a48b2"
        guard let url = URL(string: webhookURL) else { return }
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.queryItems = [
                URLQueryItem(name: "id", value: "\(pokemon.id)"),
                URLQueryItem(name: "name", value: pokemon.name),
                URLQueryItem(name: "setFavorite", value: pokemon.favorited ? "true" : "false")
            ]
            let query = components.url!.query
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = Data(query!.utf8)
            client.send(from: request) { (result) in
                switch result {
                case .success: completion(.success(()))
                case.failure: completion(.failure(.errorFetchingData))
                }
            }
        }
    }
}
