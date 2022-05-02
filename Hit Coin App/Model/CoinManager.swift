//
//  CoinManager.swift
//  Hit Coin App
//
//  Created by KimJongHee on 2022/05/02.
//

import Foundation


struct CoinManager {
    let baseUrl = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let myApiKey = "6C380E51-4038-4668-9E23-DC240C2C709F"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseUrl)/\(currency)?apikey=\(myApiKey)"
        
        if let url = URL(string: urlString)
            
    }
}
