import UIKit
import Foundation
import SnapKit


public protocol StatViewLogic {
    func set(viewModel: StatViewModel)
    var view: UIView { get }
}

public struct StatViewModel {
    public let name: String
    public let items: [Section]
}

public struct Section {
    public let name: String
    public let items: [String]
}

public final class StatView: UIView {
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = "Chlorophylle"
        label.font = UIFont.boldSystemFont(ofSize: 42)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = PokemonListTableView()
        table.showsVerticalScrollIndicator = false
        table.dataSource = self
        return table
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.startAnimating()
        return view
    }()
    
    private var items = [Section]()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reloadTableOnMain() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: -UITableViewDataSource
extension StatView: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListViewCell.reuseIdentifier, for: indexPath)
        let item = items[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
}

// MARK: - StatViewLogic
extension StatView: StatViewLogic {
    public var view: UIView {
        return self
    }
    
    public func set(viewModel: StatViewModel) {
        self.name.text = viewModel.name
        reloadTableOnMain()
        toggleView()
    }
}


// MARK: - UI Implementation
extension StatView: ViewCode {
    
    static let spacing = 20
    
    func setupHierarchy() {
        addLoadingViewHiearchy()
    }
    
    func buildConstraints() {
        buildLoadingConstraints()
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
    }
    
    // MARK: - Helpers
    func toggleView() {
        removeAllViews()
        addViewHiearchy()
        buildViewConstraints()
    }
    
    func removeAllViews() {
        view.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func addLoadingViewHiearchy() {
        addSubview(loading)
    }
    
    func addViewHiearchy() {
        addSubview(name)
    }
    
    func buildLoadingConstraints() {
        loading.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func buildViewConstraints() {
        name.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(Self.spacing)
            } else {
                make.top.equalToSuperview().offset(Self.spacing)
            }
            make.left.right.equalToSuperview().inset(Self.spacing)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(Self.spacing)
            make.left.right.bottom.equalToSuperview().inset(Self.spacing)
        }
    }
}
