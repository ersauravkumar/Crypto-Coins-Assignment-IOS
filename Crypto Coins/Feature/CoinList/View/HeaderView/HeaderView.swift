//
//  HeaderView.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 03/11/24.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func headerView(_ headerView: HeaderView, didUpdateSearchText searchText: String)
}

final class HeaderView: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .prominent
        return searchBar
    }()
    
    // MARK: - Properties
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

//MARK: Private methods
private extension HeaderView {
    
    func setupView() {
        backgroundColor = UIColor(red: 89/255, green: 13/255, blue: 228/255, alpha: 1.0)
        searchBar.delegate = self
        setupViewHierarchy()
        setupViewConstraints()
        setupInputAccessoryView()
    }
    
    func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(searchBar)
    }
    
    func setupViewConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
     func setupInputAccessoryView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [doneButton]
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.inputAccessoryView = toolbar
        }
    }
    
    @objc private func doneButtonTapped() {
        searchBar.resignFirstResponder() // Hide the keyboard
    }
}

//MARK: Exposed methods
extension HeaderView {
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

//MARK: UISearchBarDelegate Method
extension HeaderView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.headerView(self, didUpdateSearchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
