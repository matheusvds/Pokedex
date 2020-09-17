import Foundation
import UIKit
import SnapKit

public protocol PropertiesViewDelegate: class {
    func didTapAbout()
    func didTapStats()
}

public final class PropertiesView: UIView {
    
    // MARK: - Public API
    public weak var delegate: PropertiesViewDelegate?
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        setupSegmentedControl()
        setInitialTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAbout(viewModel: AboutPropertyViewModel) {
        self.about.set(viewModel: viewModel)
    }
    
    func setBaseStats(viewModel: BaseStatsPropertyViewModel) {
        self.stats.set(viewModel: viewModel)
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
    
    private lazy var stats: BaseStatsPropertyView = {
        let view = BaseStatsPropertyView()
        return view
    }()
    
    // MARK: - Actions
    private func tapAboutOption() {
        delegate?.didTapAbout()
        bringSubviewToFront(self.about)
    }
    
    private func tapStatsOption() {
        delegate?.didTapStats()
        bringSubviewToFront(stats)
    }
    
    private func setInitialTap() {
        self.sections.selectedSegmentIndex = 0
        tapAboutOption()
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
        case 2: break
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
