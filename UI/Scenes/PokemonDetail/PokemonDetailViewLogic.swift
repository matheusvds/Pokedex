import Foundation

public protocol PokemonDetailViewLogic: PropertiesViewBorder {
    var delegate: (PokemonDetailActionsDelegate & PropertiesViewDelegate)? { get set }
    func set(viewModel: PokemonDetailViewModel)
    func set(favorite: Bool)
}
