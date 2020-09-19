import Foundation
import Domain

protocol PokemonListBusinessLogic {
    func fetchPokemons(request: PokemonList.FetchPokemons.Request)
}

protocol PokemonListDataStore {
    var pokemons: [Pokemon] { get }
}

class PokemonListInteractor: PokemonListDataStore {
    var presenter: PokemonListPresentationLogic?
    var pokemons: [Pokemon]
    
    // MARK: - Use Cases
    let fetchPokemons: FetchPokemons
    
    init(fetchPokemons: FetchPokemons, pokemons: [Pokemon] = []) {
        self.fetchPokemons = fetchPokemons
        self.pokemons = pokemons
    }
}

// MARK: - UnlockBusinessLogic
extension PokemonListInteractor: PokemonListBusinessLogic {
    func fetchPokemons(request: PokemonList.FetchPokemons.Request) {
        fetchPokemons.fetch(offset: request.offset) { [weak self] (result) in
            switch result {
            case .success(let pokemons):
                self?.pokemons.append(contentsOf: pokemons)
                self?.presenter?.presentFetchPokemons(response: PokemonList.FetchPokemons.Response(pokemons: pokemons))
            case .failure:
                self?.presenter?.presentFetchPokemons(response: PokemonList.FetchPokemons.Response(pokemons: nil))
            }
        }
    }
}
