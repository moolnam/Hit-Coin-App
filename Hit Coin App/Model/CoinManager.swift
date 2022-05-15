//
//  CoinManager.swift
//  Hit Coin App
//
//  Created by KimJongHee on 2022/05/02.
//

import Foundation


protocol CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    // 프로토콜
    
    let baseUrl = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let myApiKey = "6C380E51-4038-4668-9E23-DC240C2C709F"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseUrl)/\(currency)?apikey=\(myApiKey)"
        print(urlString)
        
        if let url = URL(string: urlString) {
            // url 에다 urlString 담기
            let sesseion = URLSession(configuration: .default)
            // session 안에다 URLSeesion 디폴트 값으로 담기
            let task = sesseion.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    // 비트코인 가격이 있다면
                    if let bitCoinPrice = self.parseJSON(safeData) {
                        // bitCoinProce 안에 parseJSON 함수를 불러오는데
                        // 파라메터 안에 Data 타입이 있다. 그 Data 타입을 Double? 변환시켜서 내보낸다.
                        let bitCoinPriceString = String(format: "%.2f", bitCoinPrice)
                        delegate?.didUpdatePrice(price: bitCoinPriceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
            
            
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            // decodedData 안에 decoder.decode() 함수를 넣는다 그 함수 안에 CoinData 라는 데이터를 넣는다. decode() 함수는 Decodable 프로토콜 이라는 것 안에 있는 함수이다.
            let lastPrice = decodedData.rate
            // 마지막 가격은 CoinData 안에 있는 rate를 가져온다.
            print(lastPrice)
            return lastPrice
            // 반드시 리턴을 시켜줘야 한다.
        } catch {
            delegate?.didFailWithError(error: error)
            // 프로토콜로 만든 CoinManagerDelegate 함수로 에러를 잡는다.
            return nil
            // 반드시 리턴을 시켜줘야 한다.
        }
    }
}
