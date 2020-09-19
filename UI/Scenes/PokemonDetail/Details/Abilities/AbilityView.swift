import UIKit
import Foundation
import SnapKit

public protocol AbilityViewLogic {
    func set(viewModel: AbilityViewModel)
    var view: UIView { get }
}

public struct AbilityViewModel {
    public let name: String?
    public let abilityDescription: String?
    public let pokemons: [String]
    
    public init(name: String?, abilityDescription: String?, pokemons: [String]) {
        self.name = name
        self.abilityDescription = abilityDescription
        self.pokemons = pokemons
    }
}

public final class AbilityView: UIView, AbilityViewLogic {
    public var view: UIView {
        return self
    }
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = "Chlorophylle"
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var abilityDesc: UILabel = {
        let label = UILabel()
        label.text = "This Pokémon's Speed is doubled during strong sunlight. This bonus does not count as a stat modifier."
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .yellow
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tableTitle: UILabel = {
        let label = UILabel()
        label.text = "Pokemons with this ability"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .green
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
    
    private var items = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public func set(viewModel: AbilityViewModel) {
        self.name.text = viewModel.name
        self.abilityDesc.text = viewModel.abilityDescription
        self.items = viewModel.pokemons
        reloadTableOnMain()
        toggleView()
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
extension AbilityView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

// MARK: - UI Implementation
extension AbilityView: ViewCode {
    
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
        addSubview(abilityDesc)
        addSubview(tableTitle)
        addSubview(tableView)
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
        
        abilityDesc.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(Self.spacing)
            make.left.right.equalToSuperview().inset(Self.spacing)
        }
        
        tableTitle.snp.makeConstraints { (make) in
            make.top.equalTo(abilityDesc.snp.bottom).offset(Self.spacing)
            make.left.right.equalToSuperview().inset(Self.spacing)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(tableTitle.snp.bottom).offset(Self.spacing)
            make.left.right.bottom.equalToSuperview().inset(Self.spacing)
        }
    }
}
