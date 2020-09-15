import Foundation
import Domain

protocol PokemonDetailBusinessLogic {
    func fetchPokemons(request: PokemonDetail.DetailPokemon.Request)
}

protocol PokemonDetailDataStore {
    var pokemon: Pokemon! { get set }
}

class PokemonDetailInteractor: PokemonDetailDataStore {
    var pokemon: Pokemon!
    var presenter: PokemonDetailPresentationLogic?
}

extension PokemonDetailInteractor: PokemonDetailBusinessLogic {
    func fetchPokemons(request: PokemonDetail.DetailPokemon.Request) {
        presenter?.presentFetchPokemons(response: PokemonDetail.DetailPokemon.Response(pokemon: pokemon))
    }
}
