import Foundation

protocol PokemonListPresentationLogic {
    func presentFetchPokemons(response: PokemonList.FetchPokemons.Response)
}

class PokemonListPresenter {
    weak var displayLogic: PokemonListDisplayLogic?
}

// MARK: - PokemonListPresentationLogic

extension PokemonListPresenter: PokemonListPresentationLogic {
    func presentFetchPokemons(response: PokemonList.FetchPokemons.Response) {
        let formattedResponse = format(response)
        let viewModel = PokemonList.FetchPokemons.ViewModel(pokemons: formattedResponse)
        displayLogic?.displayFetchPokemons(viewModel: viewModel)
    }
    
    private func format(_ response: PokemonList.FetchPokemons.Response) -> [DisplayedPokemon]? {
        return response.pokemons?.map { DisplayedPokemon(name: $0.name) }
    }
}
