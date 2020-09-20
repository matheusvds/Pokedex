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
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        guard let `self` = self else { return UICollectionView() }
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(PokemonCollectionCell.self, forCellWithReuseIdentifier: PokemonCollectionCell.reuseIdentifier)
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        return flowLayout
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
            self?.collectionView.reloadData()
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
        return collectionView.indexPathsForSelectedItems?.first?.row
    }
    
    public var view: UIView {
        return self
    }
}

// MARK: - UICollectionViewDataSource
extension PokemonListView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionCell.reuseIdentifier,
                                                      for: indexPath) as! PokemonCollectionCell
        let item = items[indexPath.row]
        delegate?.set(imageView: cell.imageView, with: item.image)
        cell.set(item: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PokemonListView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height / 6
        let collectionPadding = CGFloat(20)
        let collectionWidth = collectionView.bounds.width - collectionPadding
        let cellWidth = collectionWidth / 2
        
        return CGSize(width: cellWidth, height: cellHeight);
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRow()
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detectedEnding(of: scrollView)
    }
    
    private func detectedEnding(of scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.frame.size.height*0.6
        let difference = scrollView.contentSize.height - scrollView.frame.size.height
        
        if let isLoading =  delegate?.isLoading(), offset >= difference && !isLoading {
            delegate?.reachedEndOfPage()
        }
    }
}

// MARK: - UI Implementation
extension PokemonListView: ViewCode {
    func setupHierarchy() {
        addSubview(collectionView)
    }
    
    func buildConstraints() {
        collectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(10)
            } else {
                make.top.equalToSuperview().offset(10)
            }
            make.left.right.bottom.equalToSuperview().inset(10)
        }
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
    }
}
