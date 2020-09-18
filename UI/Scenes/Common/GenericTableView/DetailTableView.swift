import UIKit
import Foundation

class DetailTableView<T: Item>: UITableView {
    
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
extension DetailTableView {
    private func setupCells() {
        register(T.cellType, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    private func setupAppereance() {
        separatorStyle = .none
    }
}
