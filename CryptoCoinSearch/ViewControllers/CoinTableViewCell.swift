//
//  CoinTableViewCell.swift
//  CryptoCoinSearch
//
//  Created by Panfilo Mariano Jr on 06/08/2019.
//  Copyright © 2019 Panfilo Mariano Jr. All rights reserved.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet private weak var borderView: UIView! {
        didSet {
            borderView.clipsToBounds = true
            borderView.layer.cornerRadius = 10
            borderView.layer.borderWidth = 1
            borderView.layer.borderColor = UIColor.fantasyGreen.cgColor
            borderView.dropShadow(color: .fantasyGreen, opacity: 1, offSet: CGSize(width: -2, height: 2), radius: 1, scale: true)
        }
    }
    @IBOutlet private weak var thumbImageView: UIImageView! {
        didSet {
            thumbImageView.clipsToBounds = true
            thumbImageView.layer.cornerRadius = 25
        }
    }
    @IBOutlet private weak var namePriceLabel: UILabel!
    @IBOutlet private weak var oneHrChangeLabel: UILabel!
    @IBOutlet private weak var twentyFourHrChangeLabel: UILabel!
    @IBOutlet private weak var sevenDayChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        borderView.dropShadow(color: .fantasyGreen, opacity: 1, offSet: CGSize(width: -2, height: 2), radius: 1, scale: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCell(_ coin: Coin) {
        
        let green = UIColor(red: 101/255.0, green: 187/255.0, blue: 106/255.0, alpha: 1)
        namePriceLabel.text = "\(coin.name) (\(coin.symbol)) $\(coin.price) USD"
        oneHrChangeLabel.text = "1h: \(coin.oneHrChange)%"
        oneHrChangeLabel.textColor = coin.oneHrChange < 0 ? .red : green
        
        twentyFourHrChangeLabel.text = "24h: \(coin.twentyFourHrChange)%"
        twentyFourHrChangeLabel.textColor = coin.twentyFourHrChange < 0 ? .red : green
        
        sevenDayChangeLabel.text = "24h: \(coin.sevenDayChange)%"
        sevenDayChangeLabel.textColor = coin.sevenDayChange < 0 ? .red : green
        
        thumbImageView.image = coin.thumb
    }
    
}
