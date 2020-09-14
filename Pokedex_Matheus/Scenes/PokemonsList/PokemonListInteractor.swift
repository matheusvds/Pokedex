import Foundation
import Domain

protocol PokemonListBusinessLogic {
    func fetchPokemons(request: PokemonList.FetchPokemons.Request)
}

protocol PokemonListDataStore {}

class PokemonListInteractor: PokemonListDataStore {
    var presenter: PokemonListPresentationLogic?
    let fetchPokemons: FetchPokemons
    
    init(fetchPokemons: FetchPokemons) {
        self.fetchPokemons = fetchPokemons
    }
}

// MARK: - UnlockBusinessLogic
extension PokemonListInteractor: PokemonListBusinessLogic {
    func fetchPokemons(request: PokemonList.FetchPokemons.Request) {
        fetchPokemons.fetch(offset: request.offset) { [weak self] (result) in
            switch result {
            case .success(let pokemons):
                self?.presenter?.presentFetchPokemons(response: PokemonList.FetchPokemons.Response(pokemons: pokemons))
            case .failure:
                self?.presenter?.presentFetchPokemons(response: PokemonList.FetchPokemons.Response(pokemons: nil))
            }
        }
    }
}
