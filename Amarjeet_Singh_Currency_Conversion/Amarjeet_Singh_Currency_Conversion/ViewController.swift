//
//  ViewController.swift
//  Amarjeet_Singh_Currency_Conversion
//
//  Created by Amarjeet Singh on 2019-07-16.
//  Copyright © 2019 Amarjeet Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var toCurrencyAmount: UITextField!
    @IBOutlet weak var fromCurrencyAmount: UITextField!
    @IBOutlet weak var toCurrencyName: UILabel!
    @IBOutlet weak var fromCurrencyName: UILabel!
    
    var conversionModel = ConversionModel()
    
    var fromIndex = 0
    var toIndex = 0
    var exchangeRate = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        pickerView(currencyPicker, didSelectRow: 0, inComponent: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return conversionModel.listOfCurrencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return conversionModel.listOfCurrencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected row \(row) in component \(component)")
        
        if(component == 0){
            fromIndex = row
        }
        else{
            toIndex = row
        }
        
        let fromCurrency = conversionModel.listOfCurrencies[fromIndex]
        let toCurrency = conversionModel.listOfCurrencies[toIndex]
        
        fromCurrencyName.text = conversionModel.currencyNames[fromCurrency]
        toCurrencyName.text = conversionModel.currencyNames[toCurrency]
        
        print("go from \(fromCurrency) to \(toCurrency))")
        conversionModel.updateExchangeRate(viewController: self, from: fromIndex, to: toIndex)
    }
    
    func updateConvertedAmount(exchangeRate: Double){
        var amountToShow = exchangeRate
        if let amountString = fromCurrencyAmount.text {
            let amountNumber = Double(amountString)
            amountToShow = amountNumber! * exchangeRate
            
        }
        
        DispatchQueue.main.async {
            self.toCurrencyAmount.text = String(amountToShow)
        }
    }
    
  
}


