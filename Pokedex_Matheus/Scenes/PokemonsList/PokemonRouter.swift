import Foundation
import UIKit

@objc protocol PokemonListRoutingLogic { }

protocol PokemonListDataPassing {
    var dataStore: PokemonListDataStore? { get }
}

class PokemonListRouter: NSObject, PokemonListRoutingLogic, PokemonListDataPassing {
    weak var viewController: UIViewController?
    var dataStore: PokemonListDataStore?
}
