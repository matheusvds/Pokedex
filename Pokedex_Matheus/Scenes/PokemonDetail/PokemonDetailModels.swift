import Foundation
import Domain

typealias DetailedPokemon = PokemonDetail.PokemonDetail.ViewModel.DetailedPokemon
typealias DetailReference = PokemonDetail.PokemonDetail.ViewModel.DetailReference

enum PokemonDetail {
    enum PokemonDetail {
        struct Request { }
        struct Response {
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            let pokemon: DetailedPokemon
            
            struct DetailedPokemon {
                let detailImage: String
                let image: String
                let id: Int
                let name: String
                let height: String
                let weight: String
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
    
    enum About {
        struct Request { }
        struct Response {
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            let height: String
            let weight: String
        }
    }
    
    enum Stat {
        struct Request { }
        struct Response {
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            let stats: [Stat]
            
            struct Stat {
                let name: String
                let value: String
                let link: String
            }
        }
    }
}
