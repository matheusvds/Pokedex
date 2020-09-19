import Foundation
import Domain

protocol PropertyDetailBusinessLogic {
    func fetchAbility(request: PropertyDetail.FetchAbility.Request)
    func fetchStat(request: PropertyDetail.FetchStat.Request)
}

protocol PropertyDetailDataStore {
    var stat: Stat! { get set }
    var ability: Ability! { get set }
}

class PropertyDetailInteractor: PropertyDetailDataStore {
    var stat: Stat!
    var ability: Ability!
    
    var presenter: PropertyDetailPresentationLogic?
    
    // MARK: - Use Cases
    let fetchURL: FetchURLInfo
    
    init(fetchURL: FetchURLInfo) {
        self.fetchURL = fetchURL
    }
}


extension PropertyDetailInteractor: PropertyDetailBusinessLogic {
    func fetchAbility(request: PropertyDetail.FetchAbility.Request) {
        let url = ability.ability.url
        fetchURL.fetch(url:url) { [weak self] (result: Result<AbilityDetail, FetchError>) in
            switch result {
            case .success(let ability):
                let response = PropertyDetail.FetchAbility.Response(abilityDetail: ability)
                self?.presenter?.presentAbility(response: response)
            case .failure: break
            }
        }
    }
    
    func fetchStat(request: PropertyDetail.FetchStat.Request) {
        
    }
}
