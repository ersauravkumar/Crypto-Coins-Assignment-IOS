//
//  FilterViewController.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 04/11/24.
//

import UIKit
import UIKit

protocol CryptoFilterViewDelegate: AnyObject {
    func didChangeFilter(_ filters: [FilterOption])
}

class CryptoFilterView: UIView {
    
    //MARK: UI Components
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FilterButtonCell.self, forCellWithReuseIdentifier: "FilterButtonCell")
        
        return collectionView
    }()
    
    private var viewModel = FilterViewModel()
    weak var delegate: CryptoFilterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CryptoFilterView {
    
    func setupView() {
        registerCollectionViewCell()
        setupViewHierarchy()
        setupViewConstraints()
    }
    
    func setupViewHierarchy() {
        addSubview(collectionView)
    }
    
    func setupViewConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func registerCollectionViewCell() {
        collectionView.register(FilterButtonCell.self, forCellWithReuseIdentifier: FilterButtonCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension CryptoFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCell.reuseIdentifier, for: indexPath) as? FilterButtonCell else { return UICollectionViewCell() }
        
        let option = viewModel.filterOptions[indexPath.item]
        cell.configure(option: option)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CryptoFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.toggleSelection(at: indexPath.item)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterButtonCell {
            cell.toggleSelection(isSelected: viewModel.filterOptions[indexPath.item].isSelected)
        }
        delegate?.didChangeFilter(viewModel.filterOptions)
    }
}
