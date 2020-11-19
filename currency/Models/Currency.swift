//
//  Currency.swift
//  currency
//
//  Created by  Vadim Tatarchuk on 19.11.2020.
//

import Foundation

struct Currency: Decodable {
    let chartCode: String
    let name: String
    let value: Float
    let previous: Float
    
    enum CodingKeys: String, CodingKey {
        case chartCode = "CharCode"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}

struct CurrenciesList: Decodable {
    let date: String
    let previousDate: String
    let currencies: [String: Currency]
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousDate = "PreviousDate"
        case currencies = "Valute"
    }
}
