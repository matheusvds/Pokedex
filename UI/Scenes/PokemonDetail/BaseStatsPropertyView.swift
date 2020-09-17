import Foundation
import SnapKit
import UIKit

class BaseStatsPropertyView: UIView, ViewCode {
    
    lazy var about: UILabel = {
        let label = UILabel()
        label.text = "Peidei podrao oh"
        label.backgroundColor = .yellow
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(about)
    }
    
    func buildConstraints() {
        about.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().inset(10)
        }
    }
    
    func additionalConfiguration() {
        backgroundColor = .red
    }
}
