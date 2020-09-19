import Foundation

public protocol PropertiesViewDelegate: GenericListViewDelegate {
    func didTapAbout()
    func didTapStats()
    func didTapAbilities()
    func didTapGames()
}

public protocol PropertiesViewBorder {
    func set(about viewModel: AboutPropertyViewModel)
    func set(stats viewModel: BaseStatsPropertyViewModel)
    func set(abilities viewModel: AbilitiesViewModel)
    func set(games viewModel: GamesViewModel)
}
