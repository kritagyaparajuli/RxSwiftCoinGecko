//
//  CoinViewModel.swift
//  GeckoRxSwift
//
//  Created by Mobile on 7/21/24.
//

import Foundation
import RxSwift

class CoinViewModel {
    var coins = BehaviorSubject<[CoinsResponseModel]>(value: [])
    private let disposeBag = DisposeBag()

    init() {
        fetchCoinsPeriodically()
    }

    func fetchCoins() {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching coins: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let responseData = try JSONDecoder().decode([CoinsResponseModel].self, from: data)
                print("Response Data: \(responseData)")  // Print the parsed response data
                self.coins.onNext(responseData)
            } catch {
                print("Error decoding response: \(error.localizedDescription)")
                print("Response Data (Raw): \(String(data: data, encoding: .utf8) ?? "N/A")")  // Print raw response data
            }
        }
        task.resume()
    }

    private func fetchCoinsPeriodically() {
        Observable<Int>.interval(.seconds(10), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.fetchCoins()
            })
            .disposed(by: disposeBag)
    }
}
