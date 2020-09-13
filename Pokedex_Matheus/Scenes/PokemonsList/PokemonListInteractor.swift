import Foundation
import Data

protocol PokemonListBusinessLogic {
    func fetchReferences(request: PokemonList.FetchPokemons.Request)
}

protocol PokemonListDataStore {}

class PokemonListInteractor: PokemonListDataStore {
    var presenter: PokemonListPresentationLogic?
    let fetchReferencesUseCase: FetchReferences
    
    init(fetchReferences: FetchReferences = RemoteFetchReferences()) {
        self.fetchReferencesUseCase = fetchReferences
    }
}

// MARK: - UnlockBusinessLogic
extension PokemonListInteractor: PokemonListBusinessLogic {
    func fetchReferences(request: PokemonList.FetchPokemons.Request) {
        fetchReferencesUseCase.fetchReferences(offset: request.offset) { [weak self] (result) in
            switch result {
            case .success(let pokemonsList):
                let response = PokemonList.FetchPokemons.Response(pokemons: pokemonsList.results)
                self?.presenter?.presentFetchPokemons(response: response)
            case .failure:
                self?.presenter?.presentFetchPokemons(response: PokemonList.FetchPokemons.Response(pokemons: nil))
            }
        }
    }
}
