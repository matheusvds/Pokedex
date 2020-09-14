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

private func makeRemoteFetchPokemonsUseCase() -> FetchPokemons {
    let urlSession = URLSessionAdapter()
    let remoteFetchReferences = RemoteFetchReferences(client: urlSession)
    let remoteFetchAllPokemons = RemoteFetchAllPokemons(client: urlSession)
    return RemoteFetchPokemons(fetchReferences: remoteFetchReferences,
                               fetchAllPokemons: remoteFetchAllPokemons)
}
