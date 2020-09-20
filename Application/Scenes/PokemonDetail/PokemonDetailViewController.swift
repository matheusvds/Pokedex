import Foundation
import UIKit
import UI

protocol PokemonDetailDisplayLogic: class {
    func displayPokemonDetail(viewModel: PokemonDetail.PokemonDetail.ViewModel)
    func displayPokemonAbout(viewModel: PokemonDetail.About.ViewModel)
    func displayPokemonStats(viewModel: PokemonDetail.Stats.ViewModel)
    func displayPokemonAbilities(viewModel: PokemonDetail.Abilities.ViewModel)
    func displayPokemonGames(viewModel: PokemonDetail.Games.ViewModel)
    func displayTappedStat(viewModel: PokemonDetail.TapStat.ViewModel)
    func displayTappedAbility(viewModel: PokemonDetail.TapAbility.ViewModel)
    func displayFavoritePokemon(viewModel: PokemonDetail.FavoritePokemon.ViewModel)
}

class PokemonDetailViewController: UIViewController {
    let interactor: PokemonDetailBusinessLogic
    let router: PokemonDetailRouterLogic
    var viewLogic: PokemonDetailViewLogic
    
    init(viewLogic: PokemonDetailViewLogic,
         interactor: PokemonDetailBusinessLogic,
         router: PokemonDetailRouterLogic) {
        self.viewLogic = viewLogic
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchPokemonDetail(request: PokemonDetail.PokemonDetail.Request())
        interactor.fetchPokemonAbout(request: PokemonDetail.About.Request())
    }
}

// MARK: - PokemonDetailDisplayLogic
extension PokemonDetailViewController: PokemonDetailDisplayLogic {
    func displayPokemonDetail(viewModel: PokemonDetail.PokemonDetail.ViewModel) {
        viewLogic.set(viewModel: PokemonDetailViewModel(name: viewModel.pokemon.name,
                                                        image: viewModel.pokemon.detailImage,
                                                        firstType: viewModel.pokemon.firstType,
                                                        secType: viewModel.pokemon.secType,
                                                        order: viewModel.pokemon.order))
    }
    
    func displayPokemonAbout(viewModel: PokemonDetail.About.ViewModel) {
        viewLogic.set(about: AboutPropertyViewModel(height: viewModel.height, weight: viewModel.weight))
    }
    
    func displayPokemonStats(viewModel: PokemonDetail.Stats.ViewModel) {
        let statsViewModel = viewModel.stats.map{ BaseStatProperty(name: $0.name,
                                                                   value: $0.value) }
        viewLogic.set(stats: BaseStatsPropertyViewModel(stats: statsViewModel))
    }
    
    func displayPokemonAbilities(viewModel: PokemonDetail.Abilities.ViewModel) {
        let viewModel = viewModel.stats.map { AbilityProperty(name: $0.name) }
        viewLogic.set(abilities: AbilitiesViewModel(abilities: viewModel))
    }
    
    func displayPokemonGames(viewModel: PokemonDetail.Games.ViewModel) {
        let viewModel = viewModel.games.map { GameProperty(name: $0.name) }
        viewLogic.set(games: GamesViewModel(games: viewModel))
    }

    func displayTappedStat(viewModel: PokemonDetail.TapStat.ViewModel) {
        router?.routeToPropertyDetail(type: .stat)
    }
    
    func displayTappedAbility(viewModel: PokemonDetail.TapAbility.ViewModel) {
        router?.routeToPropertyDetail(type: .ability)
    }
    
    func displayFavoritePokemon(viewModel: PokemonDetail.FavoritePokemon.ViewModel) {
        self.viewLogic.set(favorite: viewModel.success)
        shouldShowErrorAlert(success: viewModel.success)
    }
}

// MARK: - UI Events
extension PokemonDetailViewController: PokemonDetailDelegate {
    func set(imageView: UIImageView?, with url: String) {
        imageView?.setImage(with: url, placeholder: nil)
    }
    
    func didTapStat(at row: Int) {
        interactor.fetchTappedStat(request: PokemonDetail.TapStat.Request(row: row))
    }
    
    func didTapAbility(at row: Int) {
        interactor.fetchTappedAbility(request: PokemonDetail.TapAbility.Request(row: row))
    }
    
    func didTapBackButton() {
        router?.popViewController()
    }
    
    func didTapFavorite() {
        interactor.fetchFavoritePokemon(request: PokemonDetail.FavoritePokemon.Request())
    }

    func didTapGames() {
        interactor.fetchPokemonGames(request: PokemonDetail.Games.Request())
    }
    
    func didTapStats() {
        interactor.fetchPokemonStats(request: PokemonDetail.Stats.Request())
    }
    
    func didTapAbout() {
        interactor.fetchPokemonAbout(request: PokemonDetail.About.Request())
    }
    
    func didTapAbilities() {
        interactor.fetchPokemonAbilities(request: PokemonDetail.Abilities.Request())
    }
}

// MARK: - Helper Methods
extension PokemonDetailViewController {
    private func shouldShowErrorAlert(success: Bool) {
        guard !success else { return }
        showAlert(title: "Error", message: "An error occurred while saving 😭")
    }
}
