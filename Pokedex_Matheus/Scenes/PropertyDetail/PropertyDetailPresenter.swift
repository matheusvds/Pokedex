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
        let sections = [
            Section(name: "Affecting moves: decrease", items: response.statDetail.affectingMoves.decrease.map { $0.move.name }),
            Section(name: "Affecting moves: increase", items: response.statDetail.affectingMoves.increase.map { $0.move.name }),
            Section(name: "Affecting natures: decrease", items: response.statDetail.affectingNatures.decrease.map { $0.name }),
            Section(name: "Affecting natures: increase", items: response.statDetail.affectingNatures.increase.map { $0.name }),
            ].filter { !$0.items.isEmpty }
        let title = response.statDetail.names.filter { $0.language.name == "en" }.first?.name
        displayLogic?.displayStat(viewModel: PropertyDetail.FetchStat.ViewModel(title: title, items: sections))
    }
}
