//
//  ViewController.swift
//  Hit Coin App
//
//  Created by KimJongHee on 2022/05/02.
//

import UIKit

class ViewController: UIViewController {
    
    
    var coinManager = CoinManager()
    // CoinManager 안에 API 데이터를 받아 올 수 있게 하는 것이 들어 있다.
    
    @IBOutlet weak var bitLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        coinManager.delegate = self
        // CoinManager를 쓸수 있게 한다
        bitPicker.delegate = self
        // UIPickerViewDelegate
        bitPicker.dataSource = self
        // UIPickerViewDataSource
    }
    
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    // 프로토콜인 CoinManagerDelegate
    func didUpdatePrice(price: String, currency: String) {
        // 그 안에 함수가 담겨 있는데 CoinManagerDelegate를 CoinManager 안에다 넣고 편리하게 가져다 쓴다.
        DispatchQueue.main.async {
            // 비동기 혹은 동기적인 무엇인가 인것 같다.
            self.bitLabel.text = price
            // 데이터가 있다면 함수 안에 담겨서 price에 스트링 타입으로 담긴다.
            self.currencyLabel.text = currency
            // 데이터가 있다면 현재 선택한 통화종류가 담겨서 온다.
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


//MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        // 줄이 1줄이다 2줄로 바꾸면 충돌하는 것같다.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
        // 현재 CoinManager 안에 있는 다양한 통화 종류의 갯수만큼 불러온다.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
        // CoinManager 안에 있는 딕셔너리 안에 있는 스트링 타입을 row로 가져온다.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        // row 중 선택 된 것을 selectedCurrency 안에 담는다.
        coinManager.getCoinPrice(for: selectedCurrency)
        // 여기서 실행 된다.
        // CoinManager 안에 있는 함수 getCoinPrice() for 안에 selectedCurrency를 담는다. 이것은 스트링 타입으로 통화 종류이다. 
    }
    
}
