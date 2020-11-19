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
        priceLabel.text = "\(formatPrice)₽"
        priceLabel.textAlignment = .right
        priceLabel.textColor = currency.value > currency.previous ? .green : .red
    }
    
    func configure(for currency: CurrencyV2) {
        let optionalValue = currency.value ?? 0
        let optionalPrevious = currency.previous ?? 0
        let formatPrice = Double(optionalValue*100).rounded()/100
        let titleString = optionalValue > optionalPrevious ? "📈" : "📉"
        
        nameCurrencyLabel.text = "\(titleString) \(currency.name ?? "")"
        priceLabel.text = "\(formatPrice)₽"
        priceLabel.textAlignment = .right
        priceLabel.textColor = optionalValue > optionalPrevious ? .green : .red
    }
}
