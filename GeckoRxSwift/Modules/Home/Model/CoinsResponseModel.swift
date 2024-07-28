//
//  CoinsResponseModel.swift
//  GeckoRxSwift
//
//  Created by Mobile on 7/21/24.
//

import Foundation

struct CoinsResponseModel: Decodable {
    let id: String
    let symbol: String
    let name: String
    let current_price: Double
}
