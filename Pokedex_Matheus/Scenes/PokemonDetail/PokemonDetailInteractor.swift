import Foundation
import Domain

protocol PokemonDetailBusinessLogic {
    func fetchPokemonDetail(request: PokemonDetail.PokemonDetail.Request)
    func fetchPokemonAbout(request: PokemonDetail.About.Request)
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
        presenter?.fetchPokemonAbout(response: PokemonDetail.About.Response(pokemon: pokemon))
    }
}
