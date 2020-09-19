import Foundation
import UIKit

typealias PokemonDetailRouterLogic = (PokemonDetailRoutingLogic & PokemonDetailDataPassing)?

protocol PokemonDetailRoutingLogic {
    func popViewController()
    func routeToPropertyDetail(type: PropertyDetailType)
}

protocol PokemonDetailDataPassing {
    var dataStore: PokemonDetailDataStore? { get }
}

class PokemonDetailRouter: PokemonDetailDataPassing {
    weak var viewController: PokemonDetailViewController?
    var dataStore: PokemonDetailDataStore?
}

extension PokemonDetailRouter: PokemonDetailRoutingLogic {
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToPropertyDetail(type: PropertyDetailType) {
        let destinationVC = makeProperyDetailViewController(type: type)
        var destinationDataStore = destinationVC.router.dataStore
        passDataToPropertyDetail(source: dataStore!, destination: &destinationDataStore!)
        navigateToDetailPokemon(source: viewController, destination: destinationVC)
    }
    
    func passDataToPropertyDetail(source: PokemonDetailDataStore, destination: inout PropertyDetailDataStore) {
        destination.ability = source.ability
        destination.stat = source.stat
    }
    
    func navigateToDetailPokemon(source: PokemonDetailViewController?, destination: UIViewController) {
        DispatchQueue.main.async { [weak source] in
            source?.present(destination, animated: true, completion: nil)
        }
    }
}

