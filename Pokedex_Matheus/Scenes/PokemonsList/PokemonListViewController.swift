import UIKit

protocol PokemonListDisplayLogic: class {
    func displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel)
}

class PokemonListViewController: UIViewController {
    var interactor: PokemonListBusinessLogic?
    var router: (NSObjectProtocol & PokemonListRoutingLogic & PokemonListDataPassing)?
    
    var displayedPokemons = [DisplayedPokemon]()
    var tableView = PokemonListTableView()
    
    override func loadView() {
        self.view = tableView
    }
    
    override func viewDidLoad() {
        setup()
        start()
    }
    
    private func setup() {
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
    
    private func start() {
        fetchPokemons()
        setupTableView()
    }
}

// MARK: - Helper Methods
extension PokemonListViewController {
    private func fetchPokemons() {
        interactor?.fetchPokemons(request: PokemonList.FetchPokemons.Request())
    }
    
    private func setupTableView() {
        tableView.dataSource = self
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - PokemonListDisplayLogic
extension PokemonListViewController: PokemonListDisplayLogic {
    func displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel) {
        guard let pokemons = viewModel.pokemons else {
            return
        }
        
        displayedPokemons = pokemons
        reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListViewCell.reuseIdentifier,
                                                 for: indexPath)
        
        let item = displayedPokemons[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
}
