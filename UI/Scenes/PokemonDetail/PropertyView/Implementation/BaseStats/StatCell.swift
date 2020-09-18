import Foundation
import UIKit

class StatCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
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
extension StatCell: Identifiable { }

// MARK: - Helper Methods
extension StatCell {
    private func setupAppearance() {
        selectionStyle = .none
    }
}
