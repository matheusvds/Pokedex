import Foundation
import Data
import Domain
import Infra
import UI

func makePokemonListViewController() -> PokemonListViewController {
    let presenter = PokemonListPresenter()
    let router = PokemonListRouter()
    let interactor = PokemonListInteractor(fetchPokemons: makeRemoteFetchPokemonsUseCase())
    let view = PokemonListView()
    let viewController = PokemonListViewController(viewLogic: view, interactor: interactor, router: router)
    
    view.delegate = viewController
    presenter.displayLogic = viewController
    interactor.presenter = presenter
    router.viewController = viewController
    router.dataStore = interactor
    
    return viewController
}

func makePokemonDetailViewController() -> PokemonDetailViewController {
    let presenter = PokemonDetailPresenter()
    let router = PokemonDetailRouter()
    let interactor = PokemonDetailInteractor()
    let view = PokemonDetailView()
    let viewController = PokemonDetailViewController(viewLogic: view, interactor: interactor, router: router)
    
    view.delegate = viewController
    viewController.view = view
    presenter.displayLogic = viewController
    interactor.presenter = presenter
    router.viewController = viewController
    router.dataStore = interactor
    
    return viewController
}

func makeProperyDetailViewController(type: PropertyDetailType) -> PropertyDetailViewController {
    let presenter = PropertyDetailPresenter()
    let interactor = PropertyDetailInteractor(fetchURL: makeFetchURLRemoteUseCase())
    let router = PropertyDetailRouter()
    let viewController = PropertyDetailViewController(type: type, interactor: interactor, router: router)
    
    presenter.displayLogic = viewController
    interactor.presenter = presenter
    router.viewController = viewController
    router.dataStore = interactor
    
    return viewController
}

// MARK: - Helper Methods
private func makeRemoteFetchPokemonsUseCase() -> FetchPokemons {
    let requestClient = RequestObjectClient(client: URLSessionAdapter())
    let remoteFetchReferences = RemoteFetchReferences(client: requestClient)
    let remoteFetchAllPokemons = RemoteFetchAllPokemons(client: requestClient)
    return RemoteFetchPokemons(fetchReferences: remoteFetchReferences,
                               fetchAllPokemons: remoteFetchAllPokemons)
}


private func makeFetchURLRemoteUseCase() -> FetchURLInfo {
    let requestClient = RequestObjectClient(client: URLSessionAdapter())
    return RemoteFetchURLInfo(client: requestClient)
}
