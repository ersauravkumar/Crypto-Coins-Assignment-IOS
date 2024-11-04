//
//  CryptoCoinCell.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 04/11/24.
//

import UIKit

final class CryptoCoinCell: UITableViewCell {
    
    //MARK: UICOmponent
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let newLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = UIColor.systemGreen
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.text = " NEW "
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let cryptoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension CryptoCoinCell {
    
    func setupView() {
        setupViewHierarchy()
        setupViewConstraints()
    }
    
    func setupViewHierarchy() {
        contentView.addSubview(cryptoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(newLabel)
    }
    
    func setupViewConstraints() {
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        symbolLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        newLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        newLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        newLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        cryptoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cryptoImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cryptoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        cryptoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
    }
    
    func configureCryptoImage(coin: CryptoCoin) {
        cryptoImageView.image = coin.isActive ? UIImage(named: coin.type.imageName) : UIImage(named: "inactive_crypto")
    }
    
}

//MARK: Exposed Methods
extension CryptoCoinCell {
    func configure(with coin: CryptoCoin) {
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        newLabel.isHidden = !coin.isNew
        configureCryptoImage(coin: coin)
    }
}
