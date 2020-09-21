import Foundation
@testable import Application

func makeDisplayedPokemon() -> PokemonList.FetchPokemons.ViewModel.DisplayedPokemon {
    return PokemonList.FetchPokemons.ViewModel.DisplayedPokemon(firstType: "t1", secType: "t2", image: "url", name: "Name")
}
