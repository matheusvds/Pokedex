import Foundation

protocol PokemonDetailPresentationLogic {
    func presentPokemonDetail(response: PokemonDetail.PokemonDetail.Response)
    func presentPokemonAbout(response: PokemonDetail.About.Response)
    func presentPokemonStats(response: PokemonDetail.About.Response)
    func presentPokemonAbilities(response: PokemonDetail.Abilities.Response)
    func presentPokemonGames(response: PokemonDetail.Games.Response)
    func presentTappedStat(response: PokemonDetail.TapStat.Response)
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
        let viewModel = PokemonDetail.Stats.ViewModel(
            stats: response.pokemon.stats.map { PokemonDetail.Stats.ViewModel.Stat (name: $0.stat.name,
                                                                                    value: "\($0.baseStat)",
                link: $0.stat.url)
            }
        )
        displayLogic?.displayPokemonStats(viewModel: viewModel)
    }
    
    func presentPokemonAbilities(response: PokemonDetail.Abilities.Response) {
        let viewModel = PokemonDetail.Abilities.ViewModel(
            stats: response.pokemon.abilities.map { PokemonDetail.Abilities.ViewModel.Ability(name: $0.ability.name,
                                                                                              link: $0.ability.url)
            }
        )
        displayLogic?.displayPokemonAbilities(viewModel: viewModel)
    }
    
    func presentPokemonGames(response: PokemonDetail.Games.Response) {
        let viewModel = PokemonDetail.Games.ViewModel(
            games: response.pokemon.game_indices.map { PokemonDetail.Games.ViewModel.Game(name: $0.version.name,
                                                                                          link: $0.version.url)
            }
        )
        displayLogic?.displayPokemonGames(viewModel: viewModel)
    }
    
    func presentTappedStat(response: PokemonDetail.TapStat.Response) {
        let viewModel = PokemonDetail.TapStat.ViewModel(link: response.stat.stat.url)
        displayLogic?.displayTappedStat(viewModel: viewModel)
    }
    
    // MARK: - Helper methods
    private func format(_ response: PokemonDetail.PokemonDetail.Response) -> DetailedPokemon {
        let pokemon = response.pokemon
        return DetailedPokemon(
            detailImage: pokemon.sprites.other.officialArtwork.frontDefault,
            image: pokemon.sprites.frontDefault,
            name: pokemon.name,
            order: String(format: "#%03d", pokemon.order),
            height: "\(pokemon.height) cm",
            weight: "\(pokemon.weight) g",
            firstType: pokemon.types.first?.type.name ?? "",
            secType: pokemon.types.count == 1 ? nil : pokemon.types.last?.type.name
        )
    }
}
