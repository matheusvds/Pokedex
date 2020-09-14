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
        return response.pokemons?.map { DisplayedPokemon(image: $0.sprites.frontDefault,
                                                         order: $0.order,
                                                         id: $0.id,
                                                         name: $0.name,
                                                         height: $0.height,
                                                         weight: $0.weight,
                                                         types: $0.types.map { Reference(name: $0.type.name, link: $0.type.url) },
                                                         stats: $0.stats.map { Reference(name: $0.stat.name, value: $0.baseStat.toString(), link: $0.stat.url) },
                                                         games: $0.game_indices.map { Reference(name: $0.version.name, link: $0.version.url) },
                                                         abilities: $0.abilities.map { Reference(name: $0.ability.name, link: $0.ability.url) })
        }
    }
}
