import Foundation
import UIKit

class PokemonListViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupAppearance()
    }
}

// MARK: - Identifiable
extension PokemonListViewCell: Identifiable { }

// MARK: - Helper Methods
extension PokemonListViewCell {
    private func setupAppearance() {
        selectionStyle = .none
    }
}

