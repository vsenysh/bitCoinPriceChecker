//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate   {
    
    var coinManager = CoinManager()
   

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        bitcoinLabel.text = "N/A"
        currencyLabel.text = "N/A"
    }
    
 


}

extension ViewController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return coinManager.currencyArray.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return coinManager.currencyArray[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           let currency = (coinManager.currencyArray[row])
           coinManager.getCoinPrice(for: currency)
       }
    
    
}

extension ViewController: CoinManagerDelegate{
    
    func getCoinData(price: CoinModel){
         DispatchQueue.main.async {
             
         
             self.currencyLabel.text = price.priceString
             self.bitcoinLabel.text = price.name
            
         }
     }
    
}

