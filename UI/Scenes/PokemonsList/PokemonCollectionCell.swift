import Foundation
import UIKit
import SnapKit

class PokemonCollectionCell: UICollectionViewCell, Identifiable {
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.text = "PokeName"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var firstType: UILabel = {
        let label = RoundPaddingLabel(withInsets: 10, 10, 10, 10)
        label.text = "Poison"
        label.layer.cornerRadius = 10
        label.backgroundColor = .purple
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var secType: UILabel = {
        let label = RoundPaddingLabel(withInsets: 10, 10, 10, 10)
        label.text = "Flying"
        label.layer.cornerRadius = 10
        label.backgroundColor = .white
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func set(item: PokemonListItem) {
        self.name.text = item.name
        self.firstType.text = item.firstType
        self.firstType.backgroundColor = ColorTheme(rawValue: item.firstType)?.color
        self.secType.text = item.secType
        if let secType = item.secType {
            self.secType.backgroundColor = ColorTheme(rawValue: secType)?.color
        }
        self.secType.isHidden = item.secType == nil
        self.backgroundColor = ColorTheme(rawValue: item.firstType)?.color.withAlphaComponent(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Implementation
extension PokemonCollectionCell: ViewCode {
    func setupHierarchy() {
        addSubview(name)
        addSubview(firstType)
        addSubview(secType)
        addSubview(imageView)
    }
    
    func buildConstraints() {
        name.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().inset(15)
        }
        
        firstType.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(10)
            make.left.equalTo(name)
            make.height.equalTo(20)
        }
        
        secType.snp.makeConstraints { (make) in
            make.top.equalTo(firstType.snp.bottom).offset(5)
            make.left.equalTo(firstType)
            make.height.equalTo(20)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    func additionalConfiguration() {
        layer.cornerRadius = 15
        bringSubviewToFront(name)
        layer.masksToBounds = true
    }
}
