import Foundation
import Data
import Domain
import Infra

func makePokemonListViewController() -> PokemonListViewController {
    let presenter = PokemonListPresenter()
    let router = PokemonListRouter()
    let interactor = PokemonListInteractor(fetchPokemons: makeRemoteFetchPokemonsUseCase())
    
    let viewController = PokemonListViewController(interactor: interactor, router: router)
    
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
    
    let viewController = PokemonDetailViewController(interactor: interactor, router: router)
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
