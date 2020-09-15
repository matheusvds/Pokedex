import Foundation
import Domain

typealias DetailedPokemon = PokemonDetail.DetailPokemon.ViewModel.DetailedPokemon
typealias DetailReference = PokemonDetail.DetailPokemon.ViewModel.DetailReference

enum PokemonDetail {
    enum DetailPokemon {
        struct Request { }
        struct Response {
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            let pokemon: DetailedPokemon
            
            struct DetailedPokemon {
                let image: String
                let id: Int
                let name: String
                let height: Int
                let weight: Int
                let types: [DetailReference]
                let stats: [DetailReference]
                let games: [DetailReference]
                let abilities: [DetailReference]
            }
            
            struct DetailReference {
                let name: String
                var value: String?
                let link: String
            }
        }
    }
}
