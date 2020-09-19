import Foundation

protocol PropertyDetailPresentationLogic {
    func presentAbility(response: PropertyDetail.FetchAbility.Response)
    func presentStat(response: PropertyDetail.FetchStat.Response)
}

class PropertyDetailPresenter {
    weak var displayLogic: PropetyDetailDisplayLogic?
}
extension PropertyDetailPresenter: PropertyDetailPresentationLogic {
    
    func presentAbility(response: PropertyDetail.FetchAbility.Response) {
        let description = response.abilityDetail.effectEntries
            .filter { $0.language.name == "en" }
            .map { $0.effect }.first
        let name = response.abilityDetail.names.filter { $0.language.name == "en" }.first?.name
        let pokemons = response.abilityDetail.pokemon.map { $0.pokemon.name }
        let viewModel = PropertyDetail.FetchAbility.ViewModel(
            name: name,
            description: description,
            pokemons: pokemons)
        displayLogic?.displayAbility(viewModel: viewModel)
    }
    
    func presentStat(response: PropertyDetail.FetchStat.Response) {
        
    }
}
