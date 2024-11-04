//
//  FilterViewModel.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 04/11/24.
//

import Foundation

enum FilterType {
    case isActive
    case type(CryptoType)
    case isNew
}

struct FilterOption {
    let title: String
    var isSelected: Bool
    var type: FilterType
}

final class FilterViewModel {
    
    private(set) var filterOptions: [FilterOption] = [
        FilterOption(title: "Active Coins", isSelected: false, type: .isActive),
        FilterOption(title: "Only Coin", isSelected: false, type: .type(.coin)),
        FilterOption(title: "Only Token", isSelected: false, type: .type(.token)),
        FilterOption(title: "New Coin", isSelected: false, type: .isNew)
    ]
    
    func toggleSelection(at index: Int) {
        // Toggle the selection state of the filter option
        filterOptions[index].isSelected.toggle()
    }
    
}
