import Foundation
import UIKit

typealias PokemonListRouterLogic =  (PokemonListRoutingLogic & PokemonListDataPassing)?

protocol PokemonListRoutingLogic {
    func routeToPokemonDetail()
}

protocol PokemonListDataPassing {
    var dataStore: PokemonListDataStore? { get }
}

class PokemonListRouter: PokemonListRoutingLogic, PokemonListDataPassing {
    weak var viewController: PokemonListViewController?
    var dataStore: PokemonListDataStore?
    
    func routeToPokemonDetail() {
        let destinationVC = makePokemonDetailViewController()
        var destinationDataStore = destinationVC.router?.dataStore
        passDataToDetailPokemon(source: dataStore!, destination: &destinationDataStore!)
        navigateToDetailPokemon(source: viewController, destination: destinationVC)
    }
    
    func navigateToDetailPokemon(source: PokemonListViewController?, destination: UIViewController) {
        source?.navigationController?.pushViewController(destination, animated: true)
    }
    
    func passDataToDetailPokemon(source: PokemonListDataStore, destination: inout PokemonDetailDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.pokemon = source.pokemons[selectedRow!]
    }
}
