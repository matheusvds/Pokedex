import Foundation

protocol PokemonDetailPresentationLogic {
    func presentPokemonDetail(response: PokemonDetail.PokemonDetail.Response)
    func presentPokemonAbout(response: PokemonDetail.About.Response)
    func presentPokemonStats(response: PokemonDetail.About.Response)
}

class PokemonDetailPresenter {
    weak var displayLogic: PokemonDetailDisplayLogic?
}

// MARK: - PokemonDetailPresentationLogic
extension PokemonDetailPresenter: PokemonDetailPresentationLogic {
    func presentPokemonDetail(response: PokemonDetail.PokemonDetail.Response) {
        let formattedResponse = format(response)
        let viewModel = PokemonDetail.PokemonDetail.ViewModel(pokemon: formattedResponse)
        displayLogic?.displayPokemonDetail(viewModel: viewModel)
    }
    
    func presentPokemonAbout(response: PokemonDetail.About.Response) {
        let viewModel = PokemonDetail.About.ViewModel(
            height: "\(response.pokemon.height) cm",
            weight: "\(response.pokemon.weight) g"
        )
        displayLogic?.displayPokemonAbout(viewModel: viewModel)
    }
    
    func presentPokemonStats(response: PokemonDetail.About.Response) {
        let viewModel = PokemonDetail.Stat.ViewModel(
            stats: response.pokemon.stats.map { PokemonDetail.Stat.ViewModel.Stat (name: $0.stat.name,
                                                                                   value: "\($0.baseStat)",
                                                                                   link: $0.stat.url)
            }
        )
        displayLogic?.displayPokemonStats(viewModel: viewModel)
    }

    // MARK: - Helper methods
    private func format(_ response: PokemonDetail.PokemonDetail.Response) -> DetailedPokemon {
        let pokemon = response.pokemon
        return DetailedPokemon(detailImage: pokemon.sprites.other.officialArtwork.frontDefault,
                               image: pokemon.sprites.frontDefault,
                                id: pokemon.id,
                                name: pokemon.name,
                                height: "\(pokemon.height) cm",
                                weight: "\(pokemon.weight) g",
                                types: pokemon.types.map { DetailReference(name: $0.type.name, link: $0.type.url) },
                                stats: pokemon.stats.map { DetailReference(name: $0.stat.name, value: $0.baseStat.toString(), link: $0.stat.url) },
                                games: pokemon.game_indices.map { DetailReference(name: $0.version.name, link: $0.version.url) },
                                abilities: pokemon.abilities.map { DetailReference(name: $0.ability.name, link: $0.ability.url) })
    }
}
