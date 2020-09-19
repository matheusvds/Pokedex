import Foundation
import UIKit

public protocol PokemonListViewDelegate: class {
    func reachedEndOfPage()
    func didSelectRow()
    func set(imageView: UIImageView?, with url: String)
    func isLoading() -> Bool
}

public final class PokemonListView: UIView {
    
    public weak var delegate: PokemonListViewDelegate?
    
    private lazy var tableView: UITableView = { [weak self] in
        guard let `self` = self else { return UITableView() }
        let table = PokemonListTableView()
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private var items = [PokemonListItem]()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - PokemonListViewLogic
extension PokemonListView: PokemonListViewLogic {
    public func set(viewModel: PokemonListViewModel) {
        items.append(contentsOf: viewModel.items)
        reloadData()
    }
    
    public func getSelectedRow() -> Int? {
        return tableView.indexPathForSelectedRow?.row
    }
    
    public var view: UIView {
        return self
    }
}

// MARK: - UITableViewDataSource
extension PokemonListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListViewCell.reuseIdentifier,
                                                 for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        delegate?.set(imageView: cell.imageView, with: item.image)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PokemonListView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detectedEnding(of: scrollView)
    }
    
    private func detectedEnding(of scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.frame.size.height*0.2
        let difference = scrollView.contentSize.height - scrollView.frame.size.height
        
        if let isLoading =  delegate?.isLoading(), offset >= difference && !isLoading {
            delegate?.reachedEndOfPage()
        }
    }
}

// MARK: - UI Implementation
extension PokemonListView: ViewCode {
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func buildConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
