import Foundation

protocol PokemonListPresentationLogic {
    
}

class PokemonListPresenter {
    weak var displayLogic: PokemonListDisplayLogic?
}

// MARK: - PokemonListBusinessLogic

extension PokemonListPresenter: PokemonListBusinessLogic {
    
}
