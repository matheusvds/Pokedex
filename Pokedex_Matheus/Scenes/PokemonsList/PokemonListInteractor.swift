import Foundation

protocol PokemonListBusinessLogic {
    func fetchPokemons(request: PokemonList.FetchPokemons.Request)
}

protocol PokemonListDataStore {}

class PokemonListInteractor: PokemonListDataStore {
    var presenter: PokemonListPresentationLogic?
    let fetchPokemonsUseCase: FetchPokemons
    
    init(fetchPokemons: FetchPokemons = RemoteFetchPokemons()) {
        self.fetchPokemonsUseCase = fetchPokemons
    }
}

// MARK: - UnlockBusinessLogic
extension PokemonListInteractor: PokemonListBusinessLogic {
    func fetchPokemons(request: PokemonList.FetchPokemons.Request) {
        fetchPokemonsUseCase.fetchPokemons { [weak self] (result) in
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
