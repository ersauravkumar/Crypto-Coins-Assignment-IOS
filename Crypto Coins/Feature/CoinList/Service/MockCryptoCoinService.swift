//
//  MockCryptoCoinService.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 02/11/24.
//

import Foundation

class MockCryptoCoinService: CryptoCoinServiceProtocol {
    
    func fetchCoins(completion: @escaping (Result<[CryptoCoin], Error>) -> Void) {
        // Locate the JSON file in the bundle
        guard let url = Bundle.main.url(forResource: "MockCryptoCoinsResponse", withExtension: "json") else {
            completion(.failure(NSError(domain: "File not found", code: 0, userInfo: nil)))
            return
        }
        
        do {
            // Load the data from the file
            let data = try Data(contentsOf: url)
            // Decode the data into an array of CryptoCoin
            let coins = try JSONDecoder().decode([CryptoCoin].self, from: data)
            completion(.success(coins))
        } catch {
            completion(.failure(error))
        }
    }
}

