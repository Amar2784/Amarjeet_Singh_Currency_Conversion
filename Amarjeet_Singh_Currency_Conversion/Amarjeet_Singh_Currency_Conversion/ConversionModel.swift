//
//  ConversionModel.swift
//  Amarjeet_Singh_Currency_Conversion
//
//  Created by Amarjeet Singh on 2019-07-16.
//  Copyright © 2019 Amarjeet Singh. All rights reserved.
//

import Foundation

class ConversionModel {
    var listOfCurrencies = ["CAD","INR", "USD", "BRL", "EUR", "UAH", "AUD" ].sorted()
    
    var currencyNames : [String: String] =
        ["CAD" : "Candian Dollar",
         "INR" : "Indian Rupee",
         "BRL" : "Brazilian Real",
         "USD" : "US Dollar",
         "EUR" : "Euro",
         "AUD" : "Australian Dollar",
         "GBP" : "British Pound",
         "TRY" : "Turkish Lira"
        ]
    
    var API_BASE_URL = "https://api.exchangeratesapi.io/latest?"
    
    var fromCurrency = ""
    var toCurrency = ""
    
    func updateExchangeRate(viewController : ViewController, from: Int, to: Int ){
        fromCurrency = listOfCurrencies[from]
        toCurrency = listOfCurrencies[to]
        
        let api_url = API_BASE_URL + "base=" + fromCurrency + "&symbols=" + toCurrency
        
        print(api_url)
        
        if let url = URL(string: api_url){
            let dataTask = URLSession.shared.dataTask(with: url){
                data, response, error in
                
                if let dataRecieved = data {
                    let jsonString = String(data: dataRecieved, encoding: .utf8)
                    print(jsonString)
                    
                    do{
                        let json = try JSON(data: dataRecieved)
                        
                        let exchangeRate = json["rates"][self.toCurrency].double!
                        
                        viewController.updateConvertedAmount(exchangeRate: exchangeRate)
                        
                        print("1\(self.fromCurrency) is \(exchangeRate) \(self.toCurrency)")
                        
                        
                    } catch let err{
                        print("error reading JSON:\(err)")
                    }
            }
            
           
        }
             dataTask.resume()
    }
}
}
