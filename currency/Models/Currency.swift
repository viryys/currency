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

struct CurrencyV2: Decodable {
    let chartCode: String?
    let name: String?
    let value: Double?
    let previous: Double?
    
    init(currencyData: [String: Any]) {
        self.chartCode = currencyData["CharCode"] as? String
        self.name = currencyData["Name"] as? String
        self.value = currencyData["Value"] as? Double
        self.previous = currencyData["Previous"] as? Double
    }
}

struct CurrenciesListV2: Decodable {
    let date: String?
    let previousDate: String?
    let currencies: [CurrencyV2]?
    
    init(currenciesData: [String: Any]) {
        self.date = currenciesData["Date"] as? String
        self.previousDate = currenciesData["PreviousDate"] as? String
        
        var currenciesArr: [CurrencyV2] = []
        
        let valuteData = currenciesData["Valute"] as! [String: [String: Any]]
        for currency in valuteData {
            let val = CurrencyV2(currencyData: currency.value)
            
            currenciesArr.append(val)
        }
        
        currenciesArr.sort(by: {$0.name ?? "" < $1.name ?? ""})
        
        self.currencies = currenciesArr
        
    }
    
    static func getCurrencies(from value: Any) -> CurrenciesListV2? {
        guard let currenciesData  = value as? [String: Any] else { return nil }
        
        return  CurrenciesListV2(currenciesData: value as! [String : Any])
    }
}
