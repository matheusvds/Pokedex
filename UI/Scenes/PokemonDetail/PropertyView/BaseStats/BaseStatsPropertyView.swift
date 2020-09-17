import Foundation
import SnapKit
import UIKit

protocol BaseStatsPropertyViewDelegate: class {
    func didTapStat(link: String)
}

class BaseStatsPropertyView: UIView {
    
    weak var delegate: BaseStatsPropertyViewDelegate?
    private var stats = [BaseStatsPropertyViewModel.BaseStatProperty(name: "hahaha", value: "23", link: "")]
    
    lazy var statTable: BaseStatsTableView = {
        let label = BaseStatsTableView()
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
    
    func set(viewModel: BaseStatsPropertyViewModel) {
        self.stats = viewModel.stats
        statTable.reloadData()
    }
}


// MARK: UI Implementation
extension BaseStatsPropertyView: ViewCode {
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

extension BaseStatsPropertyView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseStatsCell.reuseIdentifier, for: indexPath)
        let item = stats[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = stats[indexPath.row]
        delegate?.didTapStat(link: item.link)
    }
}
