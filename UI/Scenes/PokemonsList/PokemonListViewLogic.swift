import Foundation
import UIKit

public protocol PokemonListViewLogic {
    var view: UIView { get }
    func set(viewModel: PokemonListViewModel)
    func getSelectedRow() -> Int?
}
