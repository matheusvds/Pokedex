import Foundation
import Domain

typealias DetailedPokemon = PokemonDetail.PokemonDetail.ViewModel.DetailedPokemon

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
                let name: String
                let order: String
                let height: String
                let weight: String
                let firstType: String
                let secType: String?
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
    
    enum Stats {
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
    
    enum Abilities {
        struct Request { }
        struct Response {
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            let stats: [Ability]
            
            struct Ability {
                let name: String
                let link: String
            }
        }
    }
    
    enum Games {
        struct Request { }
        struct Response {
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            let games: [Game]
            
            struct Game {
                let name: String
                let link: String
            }
        }
    }
    
    enum TapStat {
        struct Request {
            let row: Int
        }
        struct Response {
            let stat: Stat
        }
        
        struct ViewModel {
            let link: String
        }
    }
}
