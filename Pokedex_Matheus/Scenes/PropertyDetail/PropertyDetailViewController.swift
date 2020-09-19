import Foundation
import UIKit
import UI

enum PropertyDetailType {
    case ability
    case stat
}

protocol PropetyDetailDisplayLogic: class {
    func displayAbility(viewModel: PropertyDetail.FetchAbility.ViewModel)
    func displayStat(viewModel: PropertyDetail.FetchStat.ViewModel)
}

class PropertyDetailViewController: UIViewController, PropetyDetailDisplayLogic {
    let type: PropertyDetailType
    let interactor: PropertyDetailBusinessLogic
    let router: PropertyDetailRouter
    var abilityView: AbilityViewLogic?
    
    init(type: PropertyDetailType,
         interactor: PropertyDetailBusinessLogic,
         router: PropertyDetailRouter) {
        self.type = type
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setView(type: type)
    }
    
    override func loadView() {
        switch type {
        case .ability:
            view = abilityView?.view
        default: break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requestDetails() {
        switch type {
        case .ability:
            interactor.fetchAbility(request: PropertyDetail.FetchAbility.Request())
        case .stat:
            interactor.fetchStat(request: PropertyDetail.FetchStat.Request())
        }
    }
    
    func displayAbility(viewModel: PropertyDetail.FetchAbility.ViewModel) {
        let viewModel = AbilityViewModel(name: viewModel.name,
                                         abilityDescription: viewModel.description,
                                         pokemons: viewModel.pokemons)
        DispatchQueue.main.async { [weak self] in
            self?.abilityView?.set(viewModel: viewModel)
        }
    }
    
    func displayStat(viewModel: PropertyDetail.FetchStat.ViewModel) {
        
    }
    
    private func setView(type: PropertyDetailType) {
        switch type {
        case .ability:
            self.abilityView = AbilityView()
        default: break
        }
    }
}

