//
//  FilterButtonCell.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 04/11/24.
//

import UIKit

class FilterButtonCell: UICollectionViewCell {
    
    //MARK: UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
               
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(option: FilterOption) {
        titleLabel.text = option.title
        contentView.backgroundColor = option.isSelected ? .systemBlue : .lightGray
        titleLabel.textColor = option.isSelected ? .white : .black
    }
    
    func toggleSelection(isSelected: Bool) {
        contentView.backgroundColor = isSelected ? .systemBlue : .lightGray
        titleLabel.textColor = isSelected ? .white : .black
    }
}

//MARK: Private methods
private extension FilterButtonCell {
    
    func setupView() {
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .lightGray
        setupViewHierarchy()
        setupViewConstraints()
    }
    
    func setupViewHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    func setupViewConstraints() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
}

