//
//  CoinModel.swift
//  ByteCoin
//
//  Created by macbook on 2020-07-12.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel{
    let name: String
    let price: Double
    var priceString: String{
        return String(format: "%.1f", price)
    }
}
