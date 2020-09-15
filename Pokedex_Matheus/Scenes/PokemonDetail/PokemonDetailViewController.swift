import Foundation
import UIKit

protocol PokemonDetailDisplayLogic: class {
    func displayPokemonDetail(viewModel: PokemonDetail.DetailPokemon.ViewModel)
}

class PokemonDetailViewController: UIViewController {
    let interactor: PokemonDetailBusinessLogic
    let router: PokemonDetailRouterLogic
    
    init(interactor: PokemonDetailBusinessLogic, router: PokemonDetailRouterLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        interactor.fetchPokemons(request: PokemonDetail.DetailPokemon.Request())
    }
}

// MARK: - PokemonDetailDisplayLogic
extension PokemonDetailViewController: PokemonDetailDisplayLogic {
    func displayPokemonDetail(viewModel: PokemonDetail.DetailPokemon.ViewModel) {
        print(viewModel.pokemon.name)
    }
}
