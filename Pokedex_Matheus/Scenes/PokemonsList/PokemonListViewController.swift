import UIKit

protocol PokemonListDisplayLogic: class {
    func displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel)
}

class PokemonListViewController: UIViewController {
    var interactor: PokemonListBusinessLogic?
    var router: (NSObjectProtocol & PokemonListRoutingLogic & PokemonListDataPassing)?
    
    var displayedPokemons = [DisplayedPokemon]()
    var tableView = PokemonListTableView()
    
    //MARK: - Control
    var pagination: Int = 20
    var isLoading: Bool = true
    
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
        startLoading()
        setupTableView()
        fetchPokemons()
    }
}

// MARK: - PokemonListDisplayLogic
extension PokemonListViewController: PokemonListDisplayLogic {
    func displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel) {
        setPokemonList(viewModel)
        reloadData()
        stopLoading()
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

// MARK: - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detectedEndingOf(scrollView)
    }
}

extension PokemonListViewController {
    
    // MARK: - DisplayLogic Helpers
    private func fetchPokemons() {
        interactor?.fetchReferences(request: PokemonList.FetchPokemons.Request(offset: pagination))
    }
    
    private func fetchNewPokemonPage() {
        self.startLoading()
        self.incrementPagination()
        self.fetchPokemons()
        debugPrint("Ask new page: \(self.pagination)")
    }
    
    private func setPokemonList(_ viewModel: PokemonList.FetchPokemons.ViewModel) {
        guard let pokemons = viewModel.pokemons else {
            return
        }
        displayedPokemons.append(contentsOf: pokemons)
    }

    // MARK: - Control Helpers
    private func incrementPagination() {
        self.pagination += 20
    }
    
    private func startLoading() {
        self.isLoading = true
    }
    
    private func stopLoading() {
        self.isLoading = false
    }
    
    // MARK: - TableView Helpers
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func detectedEndingOf(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + 49
        let difference = scrollView.contentSize.height - scrollView.frame.size.height
        
        if offset >= difference && !isLoading {
            fetchNewPokemonPage()
        }
    }
}
