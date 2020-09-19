import Foundation
import Data
import Domain
import UI
import UIKit

public typealias SceneFactory = PropertyDetailFactory & PokemonDetailFactory & PokemonListFactory

public protocol PropertyDetailFactory: class {
    func makePropertyDetailViewController(type: PropertyDetailType) -> UIViewController
}
public protocol PokemonDetailFactory: class {
    func makePokemonDetailViewController() -> UIViewController
}
public protocol PokemonListFactory: class {
    func makePokemonListViewController() -> UIViewController
}

public class Main: SceneFactory {
    
    let requestObject: RequestObject
    
    public init(requestObject: RequestObject) {
        self.requestObject = requestObject
    }
    
    public func makePokemonListViewController() -> UIViewController {
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
        router.pokemonDetailFactory = self
        
        return viewController
    }

    public func makePokemonDetailViewController() -> UIViewController {
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
        router.propertyDetailFactory = self
        
        return viewController
    }

    public func makePropertyDetailViewController(type: PropertyDetailType) -> UIViewController {
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
        let remoteFetchReferences = RemoteFetchReferences(client: requestObject)
        let remoteFetchAllPokemons = RemoteFetchAllPokemons(client: requestObject)
        return RemoteFetchPokemons(fetchReferences: remoteFetchReferences,
                                   fetchAllPokemons: remoteFetchAllPokemons)
    }


    private func makeFetchURLRemoteUseCase() -> FetchURLInfo {
        return RemoteFetchURLInfo(client: requestObject)
    }

}
