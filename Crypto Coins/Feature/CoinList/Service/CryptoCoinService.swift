//
//  CryptoCoinService.swift
//  Crypto Coins
//
//  Created by Saurav Kumar on 02/11/24.
//

import Foundation

protocol CryptoCoinServiceProtocol {
    func fetchCoins(completion: @escaping (Result<[CryptoCoin], Error>) -> Void)
}

class CryptoCoinService: CryptoCoinServiceProtocol {
    
     func fetchCoins(completion: @escaping (Result<[CryptoCoin], Error>) -> Void) {
        let urlString = "https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io/"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([CryptoCoin].self, from: data)
                completion(.success(coins))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
