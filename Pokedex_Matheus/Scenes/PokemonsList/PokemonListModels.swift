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
                let image: String
                let order: Int
                let id: Int
                let name: String
                let height: Int
                let weight: Int
                let types: [Reference]
                let stats: [Reference]
                let games: [Reference]
                let abilities: [Reference]
            }
            
            struct Reference {
                let name: String
                var value: String?
                let link: String
            }
        }
    }
}
