import Foundation
import UIKit
import UI

protocol PokemonDetailDisplayLogic: class {
    func displayPokemonDetail(viewModel: PokemonDetail.PokemonDetail.ViewModel)
    func displayPokemonAbout(viewModel: PokemonDetail.About.ViewModel)
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
    func displayPokemonAbout(viewModel: PokemonDetail.About.ViewModel) {
        viewLogic.set(about: AboutPropertyViewModel(height: viewModel.height, weight: viewModel.weight))
    }
    
    func displayPokemonDetail(viewModel: PokemonDetail.PokemonDetail.ViewModel) {
        viewLogic.image.setImage(with: viewModel.pokemon.detailImage, placeholder: nil)
        viewLogic.set(viewModel: PokemonDetailViewModel(name: viewModel.pokemon.name))
    }
}

// didTapAbout() -> AboutViewModel

extension PokemonDetailViewController: PokemonDetailViewDelegate {
    func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didTapFavorite() {
        print("faved")
    }
}

extension PokemonDetailViewController: PropertiesViewDelegate {
    func didTapStats() {
        print("trocou")
    }
    
    func didTapAbout() {
        interactor.fetchPokemonAbout(request: PokemonDetail.About.Request())
    }
}
