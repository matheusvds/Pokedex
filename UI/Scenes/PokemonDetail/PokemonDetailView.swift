import Foundation
import UIKit
import SnapKit

public typealias PokemonDetailDelegate = (PokemonDetailViewDelegate & PropertiesViewDelegate)

public protocol PokemonDetailViewDelegate: class {
    func didTapBackButton()
    func didTapFavorite()
}

public protocol PokemonDetailViewLogic: PropertiesViewBorder {
    var delegate: (PokemonDetailViewDelegate & PropertiesViewDelegate)? { get set }
    var image: UIImageView { get set }
    func set(viewModel: PokemonDetailViewModel)
}

public final class PokemonDetailView: UIView, PokemonDetailViewLogic {
    
    // MARK: - Public API
    public weak var delegate: PokemonDetailDelegate? {
        didSet {
            propertiesView.delegate = delegate
        }
    }
    
    public lazy var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        propertiesView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
    
    public func set(viewModel: PokemonDetailViewModel) {
        self.title.text = viewModel.name
        self.firstType.text = viewModel.firstType
        self.secType.text = viewModel.secType
        self.secType.isHidden = viewModel.secType == nil
        self.number.text = viewModel.order
    }
    
    public func set(about viewModel: AboutPropertyViewModel) {
        self.propertiesView.set(about: viewModel)
    }
    
    public func set(stats viewModel: BaseStatsPropertyViewModel) {
        self.propertiesView.set(stats: viewModel)
    }
    
    public func set(abilities viewModel: AbilitiesViewModel) {
        self.propertiesView.set(abilities: viewModel)
    }
    
    public func set(games viewModel: GamesViewModel) {
        self.propertiesView.set(games: viewModel)
    }
    
    // MARK: - UI Components
    private lazy var back: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        return button
    }()
    
    private lazy var favorite: UIButton = {
        let button = UIButton()
        button.setTitle("Fav", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        return button
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Bulbasaur"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var number: UILabel = {
        let label = UILabel()
        label.text = "#001"
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var firstType: UILabel = {
        let label = RoundPaddingLabel()
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var secType: UILabel = {
        let label = RoundPaddingLabel()
        label.backgroundColor = .cyan
        return label
    }()
    
    private lazy var propertiesView: PropertiesView = {
        let view = PropertiesView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Actions
    private func setupTargets() {
        favorite.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        back.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }
    
    @objc private func didTapFavorite() {
        delegate?.didTapFavorite()
    }
    
    @objc private func didTapBack() {
        delegate?.didTapBackButton()
    }
}

// MARK: - UI Implementation
extension PokemonDetailView: ViewCode {
    
    static let padding = 25
    
    func setupHierarchy() {
        addSubview(back)
        addSubview(favorite)
        addSubview(title)
        addSubview(number)
        addSubview(firstType)
        addSubview(secType)
        addSubview(propertiesView)
        addSubview(image)
    }
    
    func buildConstraints() {
        
        back.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).multipliedBy(2)
            } else {
                make.top.equalToSuperview()
            }
            make.left.equalToSuperview().inset(Self.padding)
            make.height.equalTo(favorite)
        }
        
        favorite.snp.makeConstraints { (make) in
            make.centerY.equalTo(back)
            make.right.equalToSuperview().inset(Self.padding)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(back.snp.bottom).offset(Self.padding)
            make.left.equalToSuperview().inset(Self.padding)
            make.height.equalTo(30).priorityRequired()
        }
        
        number.snp.makeConstraints { (make) in
            make.centerY.equalTo(title)
            make.right.equalToSuperview().inset(Self.padding)
        }
        
        firstType.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(Self.padding/2)
            make.left.equalTo(title)
        }
        
        secType.snp.makeConstraints { (make) in
            make.left.equalTo(firstType.snp.right).offset(Self.padding/2)
            make.centerY.equalTo(firstType)
        }
        
        propertiesView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.5)
            make.left.right.bottom.equalToSuperview()
        }
        
        image.snp.makeConstraints { (make) in
            make.top.equalTo(secType.snp.bottom).offset(Self.padding)
            make.centerX.equalTo(propertiesView)
            make.bottom.equalTo(propertiesView.snp.top).inset(Self.padding)
        }
    }
    func additionalConfiguration() {
        backgroundColor = .systemPink
    }
}
