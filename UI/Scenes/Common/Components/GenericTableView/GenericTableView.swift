import Foundation
import SnapKit
import UIKit

protocol BaseStatsPropertyViewDelegate: class {
    func tableView(_ tableView: UITableView, didTap item: Item, at row: Int)
}

class GenericListView<T: Item>: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    weak var delegate: BaseStatsPropertyViewDelegate?
    private var items = [T]()
    
    lazy var statTable: UITableView = { [weak self] in
        let label = DetailTableView<T>()
        label.delegate = self
        label.dataSource = self
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: [T]) {
        self.items = viewModel
        statTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableView(tableView, didTap: items[indexPath.row], at: indexPath.row)
    }
}


// MARK: UI Implementation
extension GenericListView: ViewCode {
    func setupHierarchy() {
        addSubview(statTable)
    }
    
    func buildConstraints() {
        statTable.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().inset(10)
        }
    }
    func additionalConfiguration() {
        backgroundColor = .red
    }
}
