//
//  Crypto_CoinsTests.swift
//  Crypto CoinsTests
//
//  Created by Saurav Kumar on 04/11/24.
//

import XCTest
@testable import Crypto_Coins

final class Crypto_CoinsTests: XCTestCase {

    var viewModel: CryptoCoinViewModel!
    var mockService: MockCryptoCoinService!

    override func setUpWithError() throws {
        mockService = MockCryptoCoinService()
        viewModel = CryptoCoinViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }

    func testFetchCoinsSuccess() {
        let expectation = self.expectation(description: "Fetch coins")
        
        viewModel.fetchCoin()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Adding a slight delay to allow async fetching
            XCTAssertEqual(self.viewModel.numberOfCoins, 26) // Adjust based on your mock data
            XCTAssertEqual(self.viewModel.coin(for: 0)?.name, "Bitcoin")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSearchCoins() {
        viewModel.fetchCoin() // Ensure coins are fetched first
        
        // Simulate searching for "Bitcoin"
        viewModel.searchCoins(with: "Bitcoin")
        
        XCTAssertEqual(viewModel.numberOfCoins, 2)
        XCTAssertEqual(viewModel.coin(for: 0)?.name, "Bitcoin")
        
        // Simulate searching for an unknown coin
        viewModel.searchCoins(with: "UnknownCoin")
        XCTAssertEqual(viewModel.numberOfCoins, 0) // No matches expected
    }

    func testFilterCoins() {
        viewModel.fetchCoin() // Ensure coins are fetched first
        
        // Assuming you have a FilterOption model and method to apply filters
        let filters: [FilterOption] = [
            FilterOption(title: "Active Coins", isSelected: false, type: .isActive),
            FilterOption(title: "Only Coin", isSelected: false, type: .type(.coin))
        ]
        viewModel.applyFilters(filters)

        XCTAssertEqual(viewModel.numberOfCoins, 26)
    }
}
