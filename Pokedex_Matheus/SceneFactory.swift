import Foundation
import Data
import Infra

func makePokemonListViewController() -> PokemonListViewController {
    let remoteFetchReferences = RemoteFetchReferences(client: URLSessionAdapter())
    let presenter = PokemonListPresenter()
    let router = PokemonListRouter()
    let interactor = PokemonListInteractor(fetchReferences: remoteFetchReferences, presenter: presenter)
    let viewController = PokemonListViewController(interactor: interactor, router: router)
    
    presenter.displayLogic = viewController
    router.viewController = viewController
    router.dataStore = interactor
    
    return viewController
}
