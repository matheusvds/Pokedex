import Foundation

protocol PokemonDetailPresentationLogic {
    func presentFetchPokemons(response: PokemonDetail.DetailPokemon.Response)
}

class PokemonDetailPresenter {
    weak var displayLogic: PokemonDetailDisplayLogic?
}

// MARK: - PokemonDetailPresentationLogic
extension PokemonDetailPresenter: PokemonDetailPresentationLogic {
    func presentFetchPokemons(response: PokemonDetail.DetailPokemon.Response) {
        let formattedResponse = format(response)
        let viewModel = PokemonDetail.DetailPokemon.ViewModel(pokemon: formattedResponse)
        displayLogic?.displayPokemonDetail(viewModel: viewModel)
    }
    
    private func format(_ response: PokemonDetail.DetailPokemon.Response) -> DetailedPokemon {
        let pokemon = response.pokemon
        return DetailedPokemon(image: pokemon.sprites.frontDefault,
                                id: pokemon.id,
                                name: pokemon.name,
                                height: pokemon.height,
                                weight: pokemon.weight,
                                types: pokemon.types.map { DetailReference(name: $0.type.name, link: $0.type.url) },
                                stats: pokemon.stats.map { DetailReference(name: $0.stat.name, value: $0.baseStat.toString(), link: $0.stat.url) },
                                games: pokemon.game_indices.map { DetailReference(name: $0.version.name, link: $0.version.url) },
                                abilities: pokemon.abilities.map { DetailReference(name: $0.ability.name, link: $0.ability.url) })
    }
}
