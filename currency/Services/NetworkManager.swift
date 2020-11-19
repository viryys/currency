//
//  NetworkManager.swift
//  currency
//
//  Created by  Vadim Tatarchuk on 19.11.2020.
//

import UIKit

struct NetworkManager {
    static func fetchCurrencyData(completionHangler: @escaping (CurrenciesList) -> Void) {
        let stringURL = "https://www.cbr-xml-daily.ru/daily_json.js"
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else { return }
            
            do {
                let currency = try JSONDecoder().decode(CurrenciesList.self, from: data)
                
                completionHangler(currency)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
