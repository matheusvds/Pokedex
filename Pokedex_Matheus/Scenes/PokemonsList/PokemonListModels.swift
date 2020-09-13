import Foundation

typealias DisplayedPokemon = PokemonList.FetchPokemons.ViewModel.DisplayedPokemon

enum PokemonList {
    enum FetchPokemons {
        struct Request {
            var offset: Int = 20
        }
        struct Response {
            let pokemons: [PokemonModel]?
        }
        
        struct ViewModel {
            let pokemons: [DisplayedPokemon]?
            
            struct DisplayedPokemon {
                let name: String
            }
        }
    }
}
