import Foundation
import Domain

typealias DisplayedPokemon = PokemonList.FetchPokemons.ViewModel.DisplayedPokemon
typealias Reference = PokemonList.FetchPokemons.ViewModel.Reference

enum PokemonList {
    enum FetchPokemons {
        struct Request {
            var offset: Int = 20
        }
        struct Response {
            let pokemons: [Pokemon]?
        }
        
        struct ViewModel {
            let pokemons: [DisplayedPokemon]?
            
            struct DisplayedPokemon {
                let firstType: String
                let secType: String?
                let image: String
                let name: String
            }
            
            struct Reference {
                let name: String
                var value: String?
                let link: String
            }
        }
    }
}
