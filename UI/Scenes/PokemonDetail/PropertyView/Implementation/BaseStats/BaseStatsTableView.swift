import UIKit
import Foundation

class DetailTable<T: Identifiable>: UITableView {
    
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
extension DetailTable {
    private func setupCells() {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    private func setupAppereance() {
        separatorStyle = .none
    }
}
