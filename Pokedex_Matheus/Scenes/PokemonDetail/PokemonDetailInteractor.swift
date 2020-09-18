import Foundation
import Domain

protocol PokemonDetailBusinessLogic {
    func fetchPokemonDetail(request: PokemonDetail.PokemonDetail.Request)
    func fetchPokemonAbout(request: PokemonDetail.About.Request)
    func fetchPokemonStats(request: PokemonDetail.Stats.Request)
    func fetchPokemonAbilities(request: PokemonDetail.Abilities.Request)
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
}
