//
//  Coin.swift
//  CryptoCoinSearch
//
//  Created by Panfilo Mariano Jr on 06/08/2019.
//  Copyright © 2019 Panfilo Mariano Jr. All rights reserved.
//

import Foundation
import UIKit

struct Coin {
    var name: String
    var symbol: String
    var price: Double = 0.0
    var oneHrChange: Double = 0.0
    var twentyFourHrChange: Double = 0.0
    var sevenDayChange: Double = 0.0
    
    var thumb: UIImage?
    
    init(_ name: String, symbol: String, price: Double, oneHrChange: Double, twentyFourHrChange: Double, sevenDayChange: Double, thumb: UIImage?) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.oneHrChange = oneHrChange
        self.twentyFourHrChange = twentyFourHrChange
        self.sevenDayChange = sevenDayChange
        self.thumb = thumb
    }
}
