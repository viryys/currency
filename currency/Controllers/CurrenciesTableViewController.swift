//
//  CurrenciesTableViewController.swift
//  currency
//
//  Created by  Vadim Tatarchuk on 19.11.2020.
//

import UIKit

class CurrenciesTableViewController: UITableViewController {
    @IBOutlet var currenciesTableView: UITableView!
    
    var currencies = [Currency]()
    var updateDate: Date?
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.fetchCurrencyData { [weak self] currencies in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                var currencyArr: [Currency] = []
                
                for currency in currencies.currencies {
                    currencyArr.append(currency.value)
                }
                
                currencyArr.sort(by: {$0.name < $1.name})
                self.updateDate = self.getDateFromString(currencies.date)
                    
                self.currencies = currencyArr
                
                if let currencyUpd: Date = self.updateDate {
                    self.navigationItem.title = "Курс рубля на \(self.getStringFromDate(currencyUpd))"
                }
                
                self.currenciesTableView.reloadData()
            }
        }
    }
    
    // MARK: - Private methods
    private func getDateFromString(_ stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: stringDate) else {
            print("Error date format")
            return Date()
        }
        return date
    }
    
    private func getStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM YYYY"
        return dateFormatter.string(from: date)
    }
}

// MARK: - TableViewDataSource
extension CurrenciesTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currenciesCell", for: indexPath) as! CurrencyTableViewCell

        cell.configure(for: currencies[indexPath.row])

        return cell
    }

}
