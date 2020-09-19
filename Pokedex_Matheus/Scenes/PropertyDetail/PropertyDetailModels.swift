import Foundation
import Domain

enum PropertyDetail {
    enum FetchAbility {
        struct Request {}
        
        struct Response {
            let abilityDetail: AbilityDetail
        }
        
        struct ViewModel {
            let name: String?
            let description: String?
            let pokemons: [String]
        }
    }
    
    enum FetchStat {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
}
