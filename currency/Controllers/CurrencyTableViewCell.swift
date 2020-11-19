//
//  CurrencyTableViewCell.swift
//  currency
//
//  Created by  Vadim Tatarchuk on 19.11.2020.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameCurrencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(for currency: Currency) {
        let formatPrice = Double(currency.value*100).rounded()/100
        let titleString = currency.value > currency.previous ? "📈" : "📉"
        
        nameCurrencyLabel.text = "\(titleString) \(currency.name)"
        priceLabel.text = "\(formatPrice)"
        priceLabel.textColor = currency.value > currency.previous ? .green : .red
    }
}
