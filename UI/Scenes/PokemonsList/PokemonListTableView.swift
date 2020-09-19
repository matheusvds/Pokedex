import Foundation
import UIKit

class PokemonListTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupCells()
        setupAppereance()
    }
}

// MARK: - Helpers Methods
extension PokemonListTableView {
    private func setupCells() {
        register(PokemonListViewCell.self, forCellReuseIdentifier: PokemonListViewCell.reuseIdentifier)
    }
    
    private func setupAppereance() {
        separatorStyle = .none
    }
}
