import Foundation
import Domain

protocol PokemonDetailBusinessLogic {
    func fetchPokemonDetail(request: PokemonDetail.PokemonDetail.Request)
    func fetchPokemonAbout(request: PokemonDetail.About.Request)
    func fetchPokemonStats(request: PokemonDetail.Stats.Request)
    func fetchPokemonAbilities(request: PokemonDetail.Abilities.Request)
    func fetchPokemonGames(request: PokemonDetail.Games.Request)
    func fetchTappedStat(request: PokemonDetail.TapStat.Request)
    func fetchTappedAbility(request: PokemonDetail.TapAbility.Request)
    func fetchFavoritePokemon(request: PokemonDetail.FavoritePokemon.Request)
}

protocol PokemonDetailDataStore {
    var pokemon: Pokemon! { get set }
    var stat: Stat! { get set }
    var ability: Ability! { get set }
}

class PokemonDetailInteractor: PokemonDetailDataStore {
    var pokemon: Pokemon!
    var stat: Stat!
    var ability: Ability!
    var presenter: PokemonDetailPresentationLogic?
    
    // MARK: Use cases
    let remoteFavoriteWebHook: FavoritePokemon
    
    init(remoteFavorite: FavoritePokemon) {
        self.remoteFavoriteWebHook = remoteFavorite
    }
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
        self.stat = stat
        presenter?.presentTappedStat(response: PokemonDetail.TapStat.Response())
    }
    
    func fetchTappedAbility(request: PokemonDetail.TapAbility.Request) {
        let ability = pokemon.abilities[request.row]
        self.ability = ability
        presenter?.presentTappedAbility(response: PokemonDetail.TapAbility.Response())
    }
    
    func fetchFavoritePokemon(request: PokemonDetail.FavoritePokemon.Request) {
        remoteFavoriteWebHook.favorite(pokemon: pokemon) { [weak self] result in
            switch result {
            case .success:
                self?.presenter?.presentFavoritePokemon(response: PokemonDetail.FavoritePokemon.Response(success: true))
            case .failure:
                self?.presenter?.presentFavoritePokemon(response: PokemonDetail.FavoritePokemon.Response(success: false))
            }
        }
    }
}

