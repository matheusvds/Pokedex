import Foundation
import UIKit

typealias PokemonDetailRouterLogic = (PokemonDetailRoutingLogic & PokemonDetailDataPassing)?

protocol PokemonDetailRoutingLogic {
    func popViewController()
}

protocol PokemonDetailDataPassing {
    var dataStore: PokemonDetailDataStore? { get }
}

class PokemonDetailRouter: PokemonDetailRoutingLogic, PokemonDetailDataPassing {
    weak var viewController: UIViewController?
    var dataStore: PokemonDetailDataStore?
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true) // ROUTER
    }
}
