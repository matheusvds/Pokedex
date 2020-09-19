import Foundation
import Domain

typealias Section = PropertyDetail.FetchStat.ViewModel.Section

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
        
        struct Response {
            let statDetail: StatDetail
        }
        
        struct ViewModel {
            let title: String?
            let items: [Section]
            
            struct Section {
                let name: String
                let items: [String]
            }
        }
    }
}
