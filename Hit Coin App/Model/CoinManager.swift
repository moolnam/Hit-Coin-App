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
        
        if let url = URL(string: urlString) {
            // url 에다 urlString 담기
            let sesseion = URLSession(configuration: .default)
            // session 안에다 URLSeesion 디폴트 값으로 담기
            let task = sesseion.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                if let safeData = data {
                    
                }
            }
        }
            
            
    }
    
    func prearJSON(_ Data: data) -> Double? {
        
    }
}
