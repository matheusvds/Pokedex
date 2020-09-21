import Foundation
import UIKit

typealias PokemonListRouterLogic =  (PokemonListRoutingLogic & PokemonListDataPassing)?

protocol PokemonListRoutingLogic {
    func routeToPokemonDetail()
}

protocol PokemonListDataPassing {
    var dataStore: PokemonListDataStore? { get }
}

final class PokemonListRouter: PokemonListDataPassing {
    weak var viewController: PokemonListViewController?
    weak var pokemonDetailFactory: PokemonDetailFactory!
    var dataStore: PokemonListDataStore?
}

// MARK: - PokemonListRoutingLogic
extension PokemonListRouter: PokemonListRoutingLogic {
    func routeToPokemonDetail() {
        let destinationVC = pokemonDetailFactory.makePokemonDetailViewController() as! PokemonDetailViewController
        var destinationDataStore = destinationVC.router?.dataStore
        passDataToDetailPokemon(source: dataStore!, destination: &destinationDataStore!)
        navigateToDetailPokemon(source: viewController, destination: destinationVC)
    }
    
    func navigateToDetailPokemon(source: PokemonListViewController?, destination: UIViewController) {
        DispatchQueue.main.async { [weak source] in
            source?.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func passDataToDetailPokemon(source: PokemonListDataStore, destination: inout PokemonDetailDataStore) {
        let selectedRow = viewController?.viewLogic.getSelectedRow()
        destination.pokemon = source.pokemons[selectedRow!]
    }
}
