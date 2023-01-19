//
//  CalculatorViewController.swift
//  TinyFoundation
//
//  Created by Bytedance on 17/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class CalculatorViewController: UIViewController {
    @IBOutlet weak var buyNetValue: UITextField!
    @IBOutlet weak var buyCounts: UITextField!
    @IBOutlet weak var buyFee: UITextField!
    @IBOutlet weak var saleNetValue: UITextField!
    @IBOutlet weak var saleCounts: UITextField!
    @IBOutlet weak var saleFee: UITextField!
    
    @IBOutlet weak var earnLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var isCalculate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindSignal()
    }
    
    @IBAction func calculateAction(_ sender: Any) {
        calculateEarnMoney()
    }
    @IBAction func saveOperation(_ sender: Any) {
        calculateEarnMoney()
        saveToData()
    }
    
    func bindSignal() {
        Observable.combineLatest(buyNetValue.rx.text.orEmpty, buyCounts.rx.text.orEmpty, buyFee.rx.text.orEmpty, saleNetValue.rx.text.orEmpty, saleCounts.rx.text.orEmpty, saleFee.rx.text.orEmpty) { textValue1, textValue2, textValue3, textValue4, textValue5, textValue6 -> String in
            let name = "name"
            if textValue1.count > 0 && textValue2.count > 0 && textValue3.count > 0 && textValue4.count > 0 && textValue5.count > 0 && textValue6.count > 0 {
                self.saveButton.isEnabled = true
            }else{
                self.saveButton.isEnabled = false
            }
            return name
        }.subscribe(onDisposed: nil).disposed(by: disposeBag)
    }
    
    func calculateEarnMoney() {
        buyNetValue.resignFirstResponder()
        buyCounts.resignFirstResponder()
        buyFee.resignFirstResponder()
        saleNetValue.resignFirstResponder()
        saleCounts.resignFirstResponder()
        saleFee.resignFirstResponder()
        
        let buyNet = buyNetValue.text
        let buycounts = buyCounts.text
        let buyFee = buyFee.text
        let saleNet = saleNetValue.text
        let saleCounts = saleCounts.text
        let saleFee = saleFee.text
        
        let buyNetValue = Double(buyNet ?? "0") ?? 0
        let buyCountsValue = Double(buycounts ?? "0") ?? 0
        let buyFeeValue = Double(buyFee ?? "0") ?? 0
        let saleNetValue = Double(saleNet ?? "0") ?? 0
        let saleCountsValue = Double(saleCounts ?? "0") ?? 0
        let saleFeeValue = Double(saleFee ?? "0") ?? 0
        
        if buyNet!.count > 0 && buycounts!.count > 0 && buyFee!.count > 0 && saleNet!.count > 0 && saleCounts!.count > 0 && saleFee!.count > 0 {
            let saleMoney = saleNetValue * saleCountsValue - saleFeeValue
            let buyMoney = buyNetValue * buyCountsValue - buyFeeValue
            let earnValue = saleMoney - buyMoney
            earnLabel.text = "\(earnValue)"
            isCalculate = true
        }else {
            earnLabel.text = "无法计算收益，请补充更多信息"
            isCalculate = false
        }
    }
    
    func saveToData() {
        
        
        ProgressHUD.showSucceed("记录交易成功", interaction: false, delay: 1.5)
    }
}

extension CalculatorViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
