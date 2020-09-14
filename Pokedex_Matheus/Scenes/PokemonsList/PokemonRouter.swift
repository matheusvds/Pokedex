import Foundation
import UIKit

typealias RouterLogic =  (NSObjectProtocol & PokemonListRoutingLogic & PokemonListDataPassing)?

@objc protocol PokemonListRoutingLogic { }

protocol PokemonListDataPassing {
    var dataStore: PokemonListDataStore? { get }
}

class PokemonListRouter: NSObject, PokemonListRoutingLogic, PokemonListDataPassing {
    weak var viewController: UIViewController?
    var dataStore: PokemonListDataStore?
}
