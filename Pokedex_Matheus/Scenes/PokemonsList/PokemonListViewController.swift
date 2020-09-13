import UIKit

protocol PokemonListDisplayLogic: class {
    func displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel)
}

class PokemonListViewController: UIViewController {
    
    var interactor: PokemonListBusinessLogic?
    var router: (NSObjectProtocol & PokemonListRoutingLogic & PokemonListDataPassing)?
    
    var displayedPokemons = [DisplayedPokemon]()
    
    override func viewDidLoad() {
        print("oi")
        setup()
        start()
    }
    
    func setup() {
        let viewController = self
        let interactor = PokemonListInteractor()
        let presenter = PokemonListPresenter()
        let router = PokemonListRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.displayLogic = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func start() {
        fetchPokemons()
    }
    
    private func fetchPokemons() {
        interactor?.fetchPokemons(request: PokemonList.FetchPokemons.Request())
    }
}

extension PokemonListViewController: PokemonListDisplayLogic {
    func displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel) {
        guard let pokemons = viewModel.pokemons else {
            //error
            return
        }
        
        self.displayedPokemons = pokemons
    }
}

