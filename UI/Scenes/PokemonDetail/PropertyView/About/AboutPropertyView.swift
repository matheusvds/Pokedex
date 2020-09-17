import Foundation
import SnapKit
import UIKit

class AboutPropertyView: UIView {
    
    // MARK: Public API
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    func set(viewModel: AboutPropertyViewModel) {
        self.heightValue.text = viewModel.height
        self.weightValue.text = viewModel.weight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        plate.layer.shadowPath = UIBezierPath(rect: plate.bounds).cgPath
        plate.layer.shadowRadius = 5
        plate.layer.shadowOffset = CGSize(width: 1, height: 5)
        plate.layer.shadowOpacity = 0.1
        plate.layer.cornerRadius = 10
    }
    
    // MARK: - UI Components
    
    private lazy var about: UILabel = {
        let label = UILabel()
        label.text = "Unfortunately this pokemon doesn't have a description. Take a look a other information while we're working on that."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var height: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Height"
        return label
    }()
    
    private lazy var heightValue: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var weight: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Weight"
        return label
    }()
    
    private lazy var weightValue: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var plate: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
}

// MARK: UI Implementation
extension AboutPropertyView: ViewCode {
    
    func setupHierarchy() {
        addSubview(about)
        addSubview(plate)
        plate.addSubview(height)
        plate.addSubview(weight)
        plate.addSubview(heightValue)
        plate.addSubview(weightValue)
    }
    
    func buildConstraints() {
        about.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().inset(10)
        }
        
        plate.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(80)
            make.top.equalTo(about.snp.bottom).offset(30)
        }
        
        height.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        heightValue.snp.makeConstraints { (make) in
            make.top.equalTo(height.snp.bottom).offset(15)
            make.right.left.equalTo(height)
            make.bottom.lessThanOrEqualToSuperview().inset(15)
        }
        
        weight.snp.makeConstraints { (make) in
            make.top.equalTo(height)
            make.right.equalToSuperview().inset(30)
        }
        
        weightValue.snp.makeConstraints { (make) in
            make.top.equalTo(weight.snp.bottom).offset(15)
            make.right.left.equalTo(weight)
            make.bottom.equalTo(heightValue)
        }
    }
}
