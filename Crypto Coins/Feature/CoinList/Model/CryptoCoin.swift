//
//  CryptoCoin.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 02/11/24.
//

import Foundation

struct CryptoCoin: Codable {
    let name: String
    let symbol: String
    let type: CryptoType
    let isActive: Bool
    let isNew: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case symbol = "symbol"
        case isNew = "is_new"
        case isActive = "is_active"
        case type = "type"
    }
}

enum CryptoType: String, Codable {
    case coin
    case token
    
    var imageName: String {
        switch self {
        case .coin:
            return "coin"
        case .token:
            return "token"
        }
    }
}
