import Foundation
import UIKit
import SnapKit

public protocol PropertiesViewDelegate: class {
    func didTapAbout()
    func didTapStats()
    func didTapAbilities()
}

public protocol PropertiesViewBorder {
    func set(about viewModel: AboutPropertyViewModel)
    func set(stats viewModel: BaseStatsPropertyViewModel)
    func set(abilities viewModel: AbilitiesViewModel)
}

final class PropertiesView: UIView, PropertiesViewBorder {
    
    // MARK: - Public API
    public weak var delegate: PropertiesViewDelegate?
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        setupSegmentedControl()
        initialTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(about viewModel: AboutPropertyViewModel) {
        self.about.set(viewModel: viewModel)
    }
    
    func set(stats viewModel: BaseStatsPropertyViewModel) {
        self.stats.set(viewModel: viewModel.stats)
    }
    
    func set(abilities viewModel: AbilitiesViewModel) {
        self.abilities.set(viewModel: viewModel.abilities)
    }
        
    // MARK: - UI Components
    private let titles = ["About", "Base Stats", "Abilities" , "Games"]
    
    private lazy var sections: UISegmentedControl = { [weak self] in
        guard let `self` = self else { return UISegmentedControl() }
        let control = UISegmentedControl(items: self.titles)
        control.backgroundColor = .red
        return control
        }()
        
    private lazy var about: AboutPropertyView = {
        let view = AboutPropertyView()
        return view
    }()
    
    private lazy var stats: GenericListView<BaseStatProperty> = {
        let view = GenericListView<BaseStatProperty>()
        return view
    }()
    
    private lazy var abilities: GenericListView<AbilityProperty> = {
        let view = GenericListView<AbilityProperty>()
        return view
    }()
    
    // MARK: - Actions
    
    private func initialTap() {
        self.sections.selectedSegmentIndex = 0
        tapAboutOption()
    }
    
    private func tapAboutOption() {
        delegate?.didTapAbout()
    }
    
    private func tapStatsOption() {
        delegate?.didTapStats()
    }
    
    private func tapAbilitiesOption() {
        delegate?.didTapAbilities()
    }
    
    private func setupSegmentedControl() {
        sections.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
    }
    
    @objc private func segmentControl(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            tapAboutOption()
            removeAllViews()
            draw(view: about)
        case 1:
            tapStatsOption()
            removeAllViews()
            draw(view: stats)
        case 2:
            tapAbilitiesOption()
            removeAllViews()
            draw(view: abilities)
        case 3: break
        default:
            break
        }
    }
    
    private func removeAllViews() {
        self.about.removeFromSuperview()
        self.stats.removeFromSuperview()
    }
}

// MARK: - UI Implementation
extension PropertiesView: ViewCode {
    
    private static let padding = 10
    
    func setupHierarchy() {
        addSubview(sections)
    }
    
    func buildConstraints() {
        sections.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(Self.padding)
            make.top.equalToSuperview().offset(Self.padding)
        }
        
        draw(view: about)
    }
    
    func draw(view: UIView) {
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(sections.snp.bottom).offset(Self.padding)
            make.left.right.bottom.equalToSuperview().inset(10)
        }
    }
}
