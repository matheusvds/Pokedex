import UIKit
import Foundation

class BaseStatsTableView: UITableView {
    
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
extension BaseStatsTableView {
    private func setupCells() {
        register(BaseStatsCell.self, forCellReuseIdentifier: BaseStatsCell.reuseIdentifier)
    }
    
    private func setupAppereance() {
        separatorStyle = .none
    }
}
