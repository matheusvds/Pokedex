import Foundation
import Domain

protocol PokemonDetailBusinessLogic {
    func fetchPokemonDetail(request: PokemonDetail.PokemonDetail.Request)
    func fetchPokemonAbout(request: PokemonDetail.About.Request)
    func fetchPokemonStats(request: PokemonDetail.Stats.Request)
    func fetchPokemonAbilities(request: PokemonDetail.Abilities.Request)
    func fetchPokemonGames(request: PokemonDetail.Games.Request)
    func fetchTappedStat(request: PokemonDetail.TapStat.Request)
}

protocol PokemonDetailDataStore {
    var pokemon: Pokemon! { get set }
}

class PokemonDetailInteractor: PokemonDetailDataStore {
    var pokemon: Pokemon!
    var presenter: PokemonDetailPresentationLogic?
}

extension PokemonDetailInteractor: PokemonDetailBusinessLogic {

    func fetchPokemonDetail(request: PokemonDetail.PokemonDetail.Request) {
        presenter?.presentPokemonDetail(response: PokemonDetail.PokemonDetail.Response(pokemon: pokemon))
    }
    
    func fetchPokemonAbout(request: PokemonDetail.About.Request) {
        presenter?.presentPokemonAbout(response: PokemonDetail.About.Response(pokemon: pokemon))
    }
    
    func fetchPokemonStats(request: PokemonDetail.Stats.Request) {
        presenter?.presentPokemonStats(response: PokemonDetail.About.Response(pokemon: pokemon))
    }
    
    func fetchPokemonAbilities(request: PokemonDetail.Abilities.Request) {
        presenter?.presentPokemonAbilities(response: PokemonDetail.Abilities.Response(pokemon: pokemon))
    }
    
    func fetchPokemonGames(request: PokemonDetail.Games.Request) {
        presenter?.presentPokemonGames(response: PokemonDetail.Games.Response(pokemon: pokemon))
    }
    
    func fetchTappedStat(request: PokemonDetail.TapStat.Request) {
        let stat = pokemon.stats[request.row]
        presenter?.presentTappedStat(response: PokemonDetail.TapStat.Response(stat: stat))
        
    }
}
//            pokemon.abilities[row]
//            pokemon.game_indices[row]
