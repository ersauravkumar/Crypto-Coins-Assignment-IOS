//
//  CryptoCoinListViewController.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 02/11/24.
//

import UIKit

class CryptoCoinListViewController: UIViewController {
    
    // MARK: - UI Components
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 89/255, green: 13/255, blue: 228/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView = {
        let view = HeaderView()
        view.configure(title: "COIN")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let cryptoFilterView: CryptoFilterView = {
        let view = CryptoFilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: Variables
    private let viewModel: CryptoCoinViewModel
        
    private var safeAreaHeight: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }?.safeAreaInsets.top ?? 0.0
    }
    
    //MARK: View Life cycle
    init(viewModel: CryptoCoinViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        showIndicator()
        viewModel.fetchCoin()
    }
}

//MARK: Private methods
private extension CryptoCoinListViewController {
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        headerView.delegate = self
        cryptoFilterView.delegate = self
        viewModel.delegate = self
        registerTableViewCell()
        setupViewHierarchy()
        setupViewConstraints()
    }
    
    func setupViewHierarchy() {
        view.addSubview(topView)
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(cryptoFilterView)
        view.addSubview(activityIndicator)
    }
    
    func setupViewConstraints() {
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: safeAreaHeight).isActive = true
        
        headerView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        cryptoFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cryptoFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cryptoFilterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        cryptoFilterView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cryptoFilterView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func registerTableViewCell() {
        tableView.register(CryptoCoinCell.self, forCellReuseIdentifier: CryptoCoinCell.reuseIdentifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideIndicatorView() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}

//MARK: UITableViewDataSource Methods
extension CryptoCoinListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCoins
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCoinCell.reuseIdentifier, for: indexPath) as? CryptoCoinCell else { return UITableViewCell() }
        if let coin = viewModel.coin(for: indexPath.row) {
            cell.configure(with: coin)
        }
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: UITableViewDelegate Methods
extension CryptoCoinListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//MARK: CryptoCoinViewModelDelegate Method
extension CryptoCoinListViewController: CryptoCoinViewModelDelegate {
    
    func refreshData() {
        hideIndicatorView()
        reloadTableView()
    }
}

//MARK: HeaderViewDelegate Method
extension CryptoCoinListViewController: HeaderViewDelegate {
    
    func headerView(_ headerView: HeaderView, didUpdateSearchText searchText: String) {
        viewModel.searchCoins(with: searchText)
    }
}

//MARK: CryptoFilterViewDelegate Method
extension CryptoCoinListViewController: CryptoFilterViewDelegate {
    
    func didChangeFilter(_ filters: [FilterOption]) {
        viewModel.applyFilters(filters)
    }
}
