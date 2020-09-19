import Foundation
import UIKit

public protocol PokemonDetailViewLogic: PropertiesViewBorder {
    var delegate: (PokemonDetailActionsDelegate & PropertiesViewDelegate)? { get set }
    var image: UIImageView { get set }
    func set(viewModel: PokemonDetailViewModel)
}
