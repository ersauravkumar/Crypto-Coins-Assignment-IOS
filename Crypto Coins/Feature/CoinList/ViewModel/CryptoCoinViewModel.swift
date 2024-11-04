//
//  CryptoCoinViewModel.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 04/11/24.
//

import Foundation

protocol CryptoCoinViewModelDelegate: AnyObject {
    func refreshData()
}

final class CryptoCoinViewModel {
    
    private var allCoins: [CryptoCoin] = []
    private(set) var filteredCoins: [CryptoCoin] = []
    
    private let service: CryptoCoinServiceProtocol
    
    weak var delegate: CryptoCoinViewModelDelegate?
    
    init(service: CryptoCoinServiceProtocol) {
        self.service = service
    }
}

//MARK: Exposed methods
extension CryptoCoinViewModel {
    
    func fetchCoin() {
        service.fetchCoins { [weak self] result in
            
            guard let self else { return }
            
            switch result {
            case .success(let coins):
                self.allCoins = coins
                self.filteredCoins = coins
            case .failure(let error):
                print("Error fetching coins: \(error)")
            }
            
            self.delegate?.refreshData()
        }
    }
    
    func applyFilters(_ filters: [FilterOption]) {
        filteredCoins = allCoins.filter { coin in
            var matchesAllFilters = true // Start with the assumption that the coin matches all filters
            
            for filter in filters {
                if filter.isSelected { // Only consider selected filters
                    switch filter.type {
                    case .isActive:
                        matchesAllFilters = matchesAllFilters && (coin.isActive == true)
                    case .type(let cryptoType):
                        matchesAllFilters = matchesAllFilters && (coin.type == cryptoType)
                    case .isNew:
                        matchesAllFilters = matchesAllFilters && (coin.isNew == true)
                    }
                    
                    // If at any point a filter does not match, we can break early
                    if !matchesAllFilters {
                        return false
                    }
                }
            }
            
            return matchesAllFilters
        }
        
        delegate?.refreshData()
    }

    
    func searchCoins(with query: String) {
        if query.isEmpty {
            // If the query is empty, reset to show all coins
            filteredCoins = allCoins
        } else {
            // Filter coins by name or symbol
            filteredCoins = allCoins.filter { coin in
                coin.name.lowercased().contains(query.lowercased()) ||
                coin.symbol.lowercased().contains(query.lowercased())
            }
        }
        
        delegate?.refreshData()
    }
    
    var numberOfCoins: Int {
        filteredCoins.count
    }
    
    func coin(for index: Int) -> CryptoCoin? {
       return numberOfCoins > index ? filteredCoins[index] : nil
    }
}
