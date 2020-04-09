//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
   let currencySymbol=["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       currencyPicker.delegate=self
        currencyPicker.dataSource=self
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }//number of columns we want in our picker
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    } // nnmber of rows we want in our picker
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL=baseURL+currencyArray[row]
        let sym=currencySymbol[row]
        getBitData(url: finalURL,symbol: sym)
    }
    
    
    
    
    
    //MARK: - Networking
    /***************************************************************/

    func getBitData(url: String,symbol:String) {

        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                   // print("Sucess! Got the BIT COIN data")
                    let bitJSON : JSON = JSON(response.result.value!)

                    self.updateBitData(json: bitJSON,symbol1: symbol)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }





    //MARK: - JSON Parsing
    /***************************************************************/

    func updateBitData(json : JSON,symbol1:String) {

        if let bitResult = json["last"].double
        {
         bitcoinPriceLabel.text=symbol1 + String(bitResult)
        }
        else{
            bitcoinPriceLabel.text="Sorry,Unavailable."
        }

       // updateUIWithWeatherData()
    }





}

